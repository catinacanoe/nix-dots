{ rice, hostname, ... }: /* bash */ ''
eww kill
kill $(ps aux | grep 'eww/init.sh' | awk '{ print $2 }' | grep -v $$)
kill $(pgrep eww)

cat "$XDG_CONFIG_HOME/eww/eww.scss.gen" > "$XDG_CONFIG_HOME/eww/eww.scss"
eww open dock --restart

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

    while true; do
        percent="$(acpi -b | awk -F ', ' '{ print $2 }')"
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

        if [ "$direction" == "Not charging" ] || [ "$direction" == "Full" ]; then
            eww update "var_battery="
        else
            eww update "var_battery=$percent ($timeinfo)"
        fi
    sleep 5; done
}; battery &

function active() {
    local ws
    ws="$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"

    eww update "var_active=$ws"
    eww update "var_prev=$ws"
    eww update "var_switching=false"


    socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}' |
        while read -r active; do
            if [ "$active" != "$(eww get var_active)" ]; then
                eww update "var_switching=true" "var_prev=$(eww get var_active)" "var_active=$active"
                sleep 0.15 && eww update "var_switching=false" &
            fi
        done
}; active &

function workspaces() {
    local prev
    prev=""

    socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do
        local workspaces
        local end

        workspaces=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries' | grep -v ' *"-' | sed '/{\|}/d' | sort)

        end="$(echo "$workspaces" | tail -n 1 | awk -F '"' '{ print $2 }')"

        workspaces="$(
            echo "{"
            echo "$workspaces" | head -n -1 | sed 's|\([^,]\)$|\1,|'
            echo "$workspaces" | tail -n 1 | sed 's|,$||'
            echo "}"
        )"

        final="$(seq "1" "$end" | jq --argjson windows "$workspaces" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})')"

        if [ -z "$prev" ] || [ "$final" != "$prev" ] || [ "$final" != "$(eww get var_workspaces)" ]; then
            prev="$final"
            eww update "var_workspaces=$final"
        fi
    done
}; workspaces &

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
    echo "$hashes" | grep "ERROR" && return
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

        # maxlen="${if hostname == "nixbox" then "100" else "35"}"
        # namelen="$(echo "$name" | wc -c)"
        # if [ $namelen -gt $maxlen ]; then
        # else
        # fi
        name="$(sed -e 's|\(.\{${if hostname == "nixbox" then "100" else "35"}\}[^$]\).*|\1|' <<< "$name")"

        color="$(plyr color)"
        local testcol="$(cat /tmp/eww-test-color)"
        [ -n "$testcol" ] && color="$testcol"
        add_gradient_css "$color" reload

        eww update "var_mus_color=$color" "var_mus_playing=$(plyr playing)" "var_mus_type=$(plyr client)" "var_mus_current=$name" "var_mus_progress=$(plyr progress)" "var_mus_indicator=$(plyr indicator)" "var_mus_next=$(plyr queue)"
    sleep 0.5; done
}; music &

function visualizer() {
    sleep 1

    numbars=${toString rice.bar.cava.width}
    chars="▁▂▃▄▅▆▇█"
    charct="$(echo "$chars" | wc -m | sed 's|$| - 1|' | bc)"
    linect=${toString rice.bar.cava.height}
    heightlevels=$((linect*charct-1))

    cavasedfile=/tmp/cava.sed
    ${builtins.readFile ./cava-sed.bash}

    # make sure to clean pipe
    pipe="/tmp/cava.fifo"
    if [ -p $pipe ]; then
        unlink $pipe
    fi
    rm $pipe
    mkfifo $pipe

    # write cava config
    local config_file="/tmp/eww_cava_config"
    echo "
    [general]
    autosens=1
    bars=$numbars
    framerate=20
    higher_cutoff_freq=10000
    lower_cutoff_freq=35

    [output]
    channels=mono
    method=raw
    raw_target=$pipe
    data_format=ascii
    ascii_max_range=$heightlevels
    mono_option=average
    orientation=bottom
    " > $config_file

    # run cava in the background
    kill "$(ps aux | grep "cava -p $config_file" | awk '{ print $2 }')"
    killall cava
    sleep 0.5
    cava -p "$config_file" &

    # reading data from fifo
    while read -r line; do
        result=""
        while read -r sedcmd; do
            result="$(
                [ -n "$result" ] && echo "$result"
                echo "$line" | sed "$sedcmd"
            )"
        done < $cavasedfile 
        
        eww update "var_cava=$result"
    done < $pipe
}; visualizer &

function sussy_baka() {
    while true; do
        cat "$XDG_REPOSITORY_DIR/nix-dots/config/default.nix" | grep -q "^ *./hosts.nix *$" || \
            notify-send 'think' 'carefully'

        cat "$XDG_REPOSITORY_DIR/nix-dots/home/eww/init.nix" | grep -q "^}; sussy_baka &$" || \
            notify-send 'think' 'carefully'
    sleep 3; done
}; sussy_baka &
''
