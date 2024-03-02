{ hostname, ... }: /* bash */ ''
eww kill
kill $(ps aux | grep 'eww/init.sh' | awk '{ print $2 }' | grep -v $$)
kill $(pgrep eww)
eww open dock --restart

function net_check() {
    while true; do
        wget -q --spider http://google.com

        if [ $? -eq 0 ]; then
            eww update "var_net_check="
        else
            eww update "var_net_check= -"
        fi
    sleep 1; done
}
net_check &

function net_vpn() {
    while true; do
        vpn="$(protonvpn status | grep '^Status: ' | awk '{ print $2 }' | grep -o '^.' | sed -e 's|C|v |' -e 's|D||')"
        eww update "var_net_vpn=$vpn"
    sleep 3; done
}
net_vpn &

function vol() {
    while true; do
        setvol
    sleep 1; done
}
vol &

function bright() {
    while true; do
        setbright
    sleep 60; done
}
bright &

function active() {
    local prev
    prev="$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"

    eww update "var_active=$prev"
    eww update "var_prev=$prev"
    eww update "var_switching=false"

    socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}' |
        while read -r active; do
            if [ "$active" != "$prev" ]; then
                eww update "var_switching=true" "var_prev=$prev" "var_active=$active"

                prev="$active"

                sleep 0.15 && eww update "var_switching=false" &
            fi
        done
}
active &

function battery() {
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
}
battery &

function workspaces() {
    local prev
    prev=""

    socat -u "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do
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

        if [ -z "$prev" ] || [ "$final" != "$prev" ]; then
            prev="$final"
            eww update "var_workspaces=$final"
        fi
    done
}
workspaces &

function music() {
    local stat
    local na
    local name
    local next
    local progress
    local indicator
    local color

    while true; do
        stat="$(mpc status)"
        pctl="$(playerctl status)"

        name=""
        next=""
        indicator=""
        color="red-purple-orange"
        progress="0"
        type="mpd"

        if [ "$pctl" == "Playing" ] && echo "$stat" | sed -n 2p | grep -q '[paused]'; then
            name="$(playerctl metadata title)"
            
            if [ -n "$name" ]; then
                if echo "$name" | grep -q " - "; then true
                elif echo "$name" | grep -q " — "; then true
                else
                    name="$(playerctl metadata artist | sed 's| - Topic$||') - $name"
                fi

                name="$(echo "$name" | sed \
                -e 's|\[.*\]\s*$||' \
                -e 's+ | .* | NCS - Copyright Free Music\s*$++' \
                -e 's|\s*(.*lyric.*)\s*||i' \
                -e 's|\s*(.*video.*)\s*||i' \
                -e 's|\s*$||'
                )"

                progress="0"
                type="playerctl"
            fi
        elif [ "$(echo "$stat" | wc -l)" != "1" ]; then
            name="$(echo "$stat" | head -n 1 | sed 's|\.[^.]*$||' | grep -o '^[^{]*[^ {]')"
            next="$(mpc queue | sed 's|\.[^.]*$||' | grep -o '^[^{]*[^ {]')"
            [ "$name" == "$next" ] && next=""

            progress="$(echo "$stat" | sed -n 2p | sed -e 's|.*(||' -e 's|%)$||')"

            color="purple-orange-yellow"

            echo "$stat" | tail -n 1 | grep -q 'random: off' && indicator+="~ "
            echo "$stat" | tail -n 1 | grep -q 'single: on' && indicator+="* "
            echo "$stat" | tail -n 1 | grep -q 'repeat: off' && indicator+="- "
        fi

        name="$(echo "$name" | sed -e 's|\(.\{${if hostname == "nixbox" then "150" else "60"}\}[^$]\).*|\1 ...|')"

        eww update "var_mus_type=$type" "var_mus_current=$name" "var_mus_progress=$progress" "var_mus_color=$color" "var_mus_indicator=$indicator" "var_mus_next=$next"
    sleep 0.5; done
}
music &

function visualizer() {
    ${builtins.readFile ./cava.bash}

    # write cava config
    local config_file="/tmp/eww_cava_config"
    echo "
    [general]
    autosens=1
    bars=${if hostname=="nixbox" then "24" else "12"}
    framerate=30
    higher_cutoff_freq=10000
    lower_cutoff_freq=35

    [output]
    channels=mono
    method=raw
    raw_target=$pipe
    data_format=ascii
        ascii_max_range=$(echo "$bar" | wc -m | sed 's|$| - 2|' | bc)
    mono_option=average
    orientation=bottom
    " > $config_file

    # run cava in the background
    kill "$(ps aux | grep "cava -p $config_file" | awk '{ print $2 }')"
    sleep 0.5
    cava -p "$config_file" &

    # reading data from fifo
    while read -r cmd; do
        eww update "var_cava=$(echo "$cmd" | sed "$dict")"
    done < $pipe
}
visualizer &
''
