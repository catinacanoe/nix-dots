/* bash */ ''
dir=/home/canoe/.config/eww/state
mkdir -p "$dir"
[ -f "$dir/current" ] || touch "$dir/current"

oldid="$(cat "$dir/current")"
[ -n "$oldid" ] && touch "$dir/$oldid" && sleep 0.4

id="$(date +%s)"
echo "$id" > "$dir/current"

eww open dock --restart

function net_check() {
    while true; do
        [ -f "$dir/$id" ] && return

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
        [ -f "$dir/$id" ] && return
        setvol
    sleep 1; done # 5 min
}
vol &

function bright() {
    while true; do
        [ -f "$dir/$id" ] && return
        setbright
    sleep 60; done # 5 min
}
bright &

function active() {
    eww update "var_active=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"
    eww update "var_prev=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"
    eww update "var_switching=false"

    local prev
    prev="1"

    socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}' |
        while read -r active; do
            [ -f "$dir/$id" ] && return

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
        [ -f "$dir/$id" ] && return

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
    socat -u "UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r line; do
        [ -f "$dir/$id" ] && return

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

        eww update "var_workspaces=$(seq "1" "$end" | jq --argjson windows "$workspaces" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})')"
    done
}
workspaces &

while true; do
    [ -f "$dir/$id" ] && eww kill && pkill -P $$ && sleep 0.1 && exit
sleep 0.3; done
''
