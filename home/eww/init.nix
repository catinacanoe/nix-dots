{ rice, hostname, ... }: /* bash */ ''
eww kill
kill $(ps aux | grep 'eww/init.sh' | awk '{ print $2 }' | grep -v $$)
kill $(pgrep eww)

cat "$XDG_CONFIG_HOME/eww/eww.scss.gen" > "$XDG_CONFIG_HOME/eww/eww.scss"
eww open dock-0 --restart
eww open dock-1

hyprctl dispatch event eww,init,start

function net_check() {
    while true; do
        local result=""
        ping -c 1 google.com &> /dev/null || result=" -"

        eww update "var_net_check=$result"
        echo "$result" > /tmp/net-check
    sleep 1; done
}; net_check &

function net_vpn() {
    local vpn
    while true; do
        [ -z "$(wg 2>&1)" ] && vpn="" || vpn="v "
        eww update "var_net_vpn=$vpn"
    sleep 1; done
}; net_vpn &

function vol() {
    while true; do
        setvol silent
    sleep 1; done
}; vol &

function bright() {
    while true; do
        setbright silent
    sleep 60; done
}; bright &

function battery() {
    # can eventually start using `upower -d` instead of `acpi -b`

    lowbatnum=15
    exlowbatnum=10
    lowbat=""
    exlowbat=""

    while true; do
        percent="$(acpi -b | awk -F ', ' '{ print $2 }')"
        percentnum="$(echo "$percent" | sed 's|%$||')"
        timestamp="$(acpi -b | awk -F ', ' '{ print $3 }' | awk '{ print $1 }' )"
        hour="$(echo "$timestamp" | awk -F ':' '{ print $1 }')"
        min="$(echo "$timestamp" | awk -F ':' '{ print $2 }')"
        sec="$(echo "$timestamp" | awk -F ':' '{ print $3 }')"

        direction="$(acpi -b | sed -e 's|^Battery .: ||' -e 's|, .*||')"

        timeinfo="$(
        [ "$direction" == "Charging" ] && echo -n "+"
        [ "$direction" == "Discharging" ] && echo -n "-"

        if [[ $min -le 0 ]]; then
            echo "$sec"s
        elif [[ $hour -le 0 ]]; then
            math="$min + $sec/60"
            time="$(bc <<< "scale = 1; $math")"
            [ "$(echo "$time" | wc --chars)" -gt 4 ] && time="$(bc <<< "$math")" # wc counts \n
            echo "$time"m
        else
            math="$hour + $min/60"
            time="$(bc <<< "scale = 1; $math")"
            [ "$(echo "$time" | wc --chars)" -gt 4 ] && time="$(bc <<< "$math")"
            echo "$time"h
        fi
        )"

        if [ "$direction" == "Full" ]; then
            eww update "var_battery="
        elif [ "$direction" == "Not charging" ]; then
            if [ "$percent" == "100%" ]; then
                eww update "var_battery="
            else
                eww update "var_battery=$percent"
            fi
        else
            eww update "var_battery=$percent ($timeinfo)"

            if [ "$direction" == "Charging" ]; then
                if [ $percentnum -gt $lowbatnum ]; then
                    lowbat=""
                fi

                if [ $percentnum -gt $exlowbatnum ]; then
                    exlowbat=""
                fi
            elif [ "$direction" == "Discharging" ]; then
                if [ $percentnum -le $lowbatnum ]; then
                    if [ -z "$lowbat" ]; then
                        notify-send "Warning" "Low battery: $percent"
                        [ $(eww get var_brightness) -gt $lowbatnum ] && setbright "$lowbatnum%"
                        lowbat="asd"
                    fi
                fi

                if [ $percentnum -le $exlowbatnum ]; then
                    if [ -z "$exlowbat" ]; then
                        notify-send "Warning" "Extremely low battery: $percent"
                        [ $(eww get var_brightness) -gt $exlowbatnum ] && setbright "$exlowbatnum%"
                        exlowbat="asd"
                    fi
                fi
            fi
        fi
    sleep 5; done
}; battery &

# opens the corresponding dock when a monitor is connected
function watch_monitors() {
    # socat watches the hyprland ipc, listens for events
    # events are formatted like so: $eventname>>$1,$2,$3
    # so using awk we select for the events we want, then split by >> or , and select the argument we want, which is passed into the loop var

    # this watches for monitoradded event and selects the portname of the monitor (ie eDP-1)
    socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
        stdbuf -o0 awk -F '>>|,' -e '/^monitoradded>>/ {print $2}' |
        while read -r port; do

            case "$port" in
                "${rice.monitor.primary.port}")   sleep 1 && eww open dock-0 ;;
                "${rice.monitor.secondary.port}") sleep 1 && eww open dock-1 ;;
            esac
        done
}; watch_monitors &

function monitor_count() {
    while true; do
        sleep 1
        eww update "var_monitor_ct=$(hyprctl monitors all -j | jq length)"
    done
}; monitor_count &

ws_switch_time=0.15

# watches for changes in active workspace and updates eww accordingly
function active() {
    # watches for change in focused workspace or monitor, and end of eww init (also a periodic event, because sometimes changes are missed)
    socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/' -e '/^focusedmon>>/' -e '/^custom>>eww,init,end/' -e '/^custom>>periodic,1/' |
        while read -r line; do
            monlist="$(hyprctl monitors -j | jq '.[] | {"mon": .name, "active": .activeWorkspace.id}' | sed -e 's|"${rice.monitor.primary.port}"|0|' -e 's|"${rice.monitor.secondary.port}"|1|' | jq -s 'sort_by(.mon)')"
            mons="$(echo "$monlist" | jq '.[].mon')"
            maxmon="$(echo "$mons" | sort | tail -n 1)"
            [ "$mons" != "$(seq 0 $maxmon)" ] && monlist="$(echo "$monlist" | jq '.[]' | cat - <(echo '{ "mon": 0, "active": 0 }') | jq -s 'sort_by(.mon)')"
            # the above basically makes sure that all monitors are present (ie if mon 0 is disconnected, we still want the id of mon 1 to appear second in list, so we create a dummy mon 0 value)
            # the code will have to be rewritten if it needs to support more than 2 monitors (because here the only monitor disconnect that messes things up is mon0, this will not be the case with >2 monitors)

            active="$(echo "$monlist" | jq '.[].active' | jq -s)"
            prev="$(eww get var_active_ws)"
            switch="$(jq -n --argjson a "$active" --argjson b "$prev" '[$a, $b] | transpose | .[] | .[0] != .[1]' | jq -s)"

            falselist="$(echo "$active" | jq '.[] | false' | jq -s)"

            if [ "$active" != "$prev" ]; then
                eww update "var_switching_ws=$switch" "var_prev_ws=$prev" "var_active_ws=$active"
                sleep $ws_switch_time && eww update "var_switching_ws=$falselist" &
            fi
        done
}; active &

# updates eww on which workspaces are open and how many windows each contains
function workspaces() {
    local prev
    prev=""

    local wsrange_start=1
    local wsrange_end=40

    # loop only runs on openwindow, closewindow, activewindow, workspace, or focusedmon event
    socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
    stdbuf -o0 awk -F '>>|,' -e '/^openwindow>>/' -e '/^closewindow>>/' -e '/^movewindow>>/' -e '/^createworkspace>>/' -e '/^destroyworkspace>>/' -e '/^custom>>eww,init,end/' | # -e '/^focsedmon>>/' |
    while read -r line; do
        local workspaces
        local end

        # grep removes negative entries
        # sed removes the brackets at top and bottom
        workspaces="$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries' | grep -v ' *"-' | sed '/{\|}/d')"

        # get the highest open id for each monitor
        max0=0
        max1=0
        max2=0
        max3=0
        while IFS= read -r id; do
            [ $id -lt 9 ] && max0=$id
            [ $id -lt 19 ] && max1=$id
            [ $id -lt 29 ] && max2=$id
            [ $id -lt 39 ] && max3=$id
        done <<< "$(echo "$workspaces" | awk -F '"' '{print $2}' | sed 's|^\(.\)$|0\1|' | sort | sed 's|^0||')"

        # 1st sed adds comma to lines that lack one
        # 2nd sed removes comma from last line
        workspaces="$(
            echo "{"
            echo "$workspaces" | head -n -1 | sed 's|\([^,]\)$|\1,|' 
            echo "$workspaces" | tail -n 1 | sed 's|,$||'
            echo "}"
        )"

        range="$(seq 1 $max0 && seq 11 $max1 && seq 21 $max2 && seq 31 $max3)"
        final="$(echo "$range" | jq --argjson windows "$workspaces" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})')"

        if [ -z "$prev" ] || [ "$final" != "$prev" ] || [ "$final" != "$(eww get var_workspaces)" ]; then
            prev="$final"
            eww update "var_workspaces=$final"
        fi
    done
}; workspaces &

# converts color names to hex
function get_col_hex() {
    case "$1" in
        "fg") echo "${rice.col.fg.h}" ;;
        "mg") echo "${rice.col.mg.h}" ;;
        "bg") echo "${rice.col.bg.h}" ;;

        "t0") echo "${rice.col.t0.h}" ;;
        "t1") echo "${rice.col.t1.h}" ;;
        "t2") echo "${rice.col.t2.h}" ;;
        "t3") echo "${rice.col.t3.h}" ;;
        "t4") echo "${rice.col.t4.h}" ;;
        "t5") echo "${rice.col.t5.h}" ;;
        "t6") echo "${rice.col.t6.h}" ;;
        "t7") echo "${rice.col.t7.h}" ;;

        "red")    echo "${rice.col.red.h}" ;;
        "orange") echo "${rice.col.orange.h}" ;;
        "yellow") echo "${rice.col.yellow.h}" ;;
        "green")  echo "${rice.col.green.h}" ;;
        "aqua")   echo "${rice.col.aqua.h}" ;;
        "blue")   echo "${rice.col.blue.h}" ;;
        "purple") echo "${rice.col.purple.h}" ;;
        "brown")  echo "${rice.col.brown.h}" ;;
        *) echo "ERROR" ;;
    esac
}

function add_gradient_css() {
    local name="$1"
    cat "$XDG_CONFIG_HOME/eww/eww.scss" | grep -q "^/\* autogen \*/ \.$name " && return

    local colors="$(echo "$name" | tr '-' '\n')"

    local text='bg'
    if [ "$(echo "$colors" | grep 'bg\|t0\|t1\|t2' | wc -l)" -gt "$(echo "$colors" | grep 'fg\|t7\|t6' | wc -l)" ]; then
        text='fg'
    fi

    local hashes="$(
    while IFS= read -r line; do
        hash="$(get_col_hex "$line")"
        echo -n "$hash, "
    done <<< "$colors"
    echo
    )"
    echo "$hashes" | grep "ERROR" && return # if any hex code was not possible to locate
    hashes="$(echo "$hashes" | sed 's|, $||' )"

    local texthash="$(get_col_hex "$text")"

    echo "/* autogen */ .$name { background-image: linear-gradient(115deg, $hashes); color: $texthash; }" >> "$XDG_CONFIG_HOME/eww/eww.scss"
    if [ "$2" == "reload" ]; then
        sleep 0.3
        local ws="$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"
        eww update "var_switching=false" "var_prev=$ws" "var_active=$ws" "var_mus_color=preview"
    fi
}

function update_css_from_index() {
    local colors="$(grep -o ' t=[^ ]*' "$XDG_MUSIC_DIR/.index" | sed 's|^ t=||')"

    while IFS= read -r colname; do
        add_gradient_css "$colname"
    done <<< "$colors"

    sleep 0.3
    local ws="$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"
    eww update "var_switching=false" "var_prev=$ws" "var_active=$ws"
}; update_css_from_index &

function music() {
    local name
    local color

    while true; do
        # char limit
        name="$(plyr current)"

        name="$(sed -e 's|\(.\{${if hostname == "nixbox" then "100" else "35"}\}[^$]\).*|\1|' <<< "$name")"

        color="$(plyr color)"
        local testcol="$(cat /tmp/eww-test-color)"
        [ -n "$testcol" ] && color="$testcol"
        add_gradient_css "$color" reload

        eww update "var_mus_color=$color" "var_mus_playing=$(plyr playing)" "var_mus_type=$(plyr client)" "var_mus_current=$name" "var_mus_progress=$(plyr progress)" "var_mus_indicator=$(plyr indicator)" "var_mus_next=$(plyr queue)"
    sleep 0.5; done
}; music &

# function visualizer() {
#     sleep 1

#     numbars=${toString rice.bar.cava.width}
#     chars="▁▂▃▄▅▆▇█"
#     charct="$(echo "$chars" | wc -m | sed 's|$| - 1|' | bc)"
#     linect=${toString rice.bar.cava.height}
#     heightlevels=$((linect*charct-1))

#     flatline="$(
#         seq 2 $linect | sed "s|.*|$(seq 1 $numbars | tr '\n' ' ' | sed "s|[^ ]* | |g" && echo)|"
#         seq 1 $numbars | tr '\n' ' ' | sed "s|[^ ]* |$(sed 's|\(.\).*|\1|' <<< "$chars")|g" && echo
#     )"
#     
#     eww update "var_cava_flatline=$flatline"

#     cavasedfile=/tmp/cava.sed
#     $${builtins.readFile ./cava-sed.bash}

#     # make sure to clean pipe
#     pipe="/tmp/cava.fifo"
#     if [ -p $pipe ]; then
#         unlink $pipe
#     fi
#     rm $pipe
#     mkfifo $pipe

#     # write cava config
#     local config_file="/tmp/eww_cava_config"
#     echo "
#     [general]
#     autosens=1
#     bars=$numbars
#     framerate=20
#     higher_cutoff_freq=10000
#     lower_cutoff_freq=35

#     [output]
#     channels=mono
#     method=raw
#     raw_target=$pipe
#     data_format=ascii
#     ascii_max_range=$heightlevels
#     mono_option=average
#     orientation=bottom
#     " > $config_file

#     # run cava in the background
#     kill "$(ps aux | grep "cava -p $config_file" | awk '{ print $2 }')"
#     killall cava
#     sleep 0.5
#     cava -p "$config_file" &

#     # reading data from fifo
#     while read -r line; do
#         result=""
#         while read -r sedcmd; do
#             result="$(
#                 [ -n "$result" ] && echo "$result"
#                 echo "$line" | sed "$sedcmd"
#             )"
#         done < $cavasedfile 
#         
#         eww update "var_cava=$result"
#     done < $pipe
# }; visualizer &

function periodic_event() {
    while true; do
        hyprctl dispatch event periodic,1 # the 1 indicates one second period
    sleep 1; done
}

sleep 0.5
hyprctl dispatch event eww,init,end
''
