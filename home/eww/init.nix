/* bash */ ''
eww kill
kill $(ps aux | grep 'eww/init.sh' | grep -v $$)
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
    sleep 3; done
}
net_check &

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

                sleep 0.2 && eww update "var_switching=false" &
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
            [ "$percent" == "99" ] && percent=100
            eww update "var_battery=$percent"
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
        local start
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
    while true; do
        stat="$(mpc status)"

        if [ "$(echo "$stat" | wc -l)" == "1" ]; then
            name="nothing playing"
            progress="0:00/0:00"
            color=""
        else
            name="$(echo "$stat" | head -n 1 | sed 's|\.[^.]*$||' | grep -o '^[^{]*[^ {]')"
            progress="$(echo "$stat" | sed -n 2p | sed -e 's|.*(||' -e 's|%)$||')"
            color="aqua-blue"
        fi

        eww update "var_mus_current=$name" "var_mus_progress=$progress" "var_mus_color=$color"
    sleep 0.5; done
}
music &
''
