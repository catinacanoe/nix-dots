/* bash */ ''
dir=/home/canoe/.config/eww/listen
mkdir -p "$dir"

echo "kill" > "$dir/kill"
sleep 0.4
echo "" > "$dir/kill"

eww open dock --restart

function net_vpn() {
    echo > "$dir/net-vpn"

    while true; do
        protonvpn status | grep '^Status: ' | awk '{ print $2 }' \
        | grep -o '^.' | sed -e 's|C|v |' -e 's|D||' >> "$dir/net-vpn"

    sleep 5; done
}

function net_check() {
    echo > "$dir/net-check"

    while true; do
        wget -q --spider http://google.com

        if [ $? -eq 0 ]; then
            echo "" > "$dir/net-check"
        else
            echo " -" > "$dir/net-check"
        fi

    sleep 3; done
}

function vol() {
    echo > "$dir/audio-device"
    echo > "$dir/volume"

    while true; do
        setvol
    sleep 1; done # 5 min
}

function bright() {
    echo > "$dir/brightness"

    while true; do
        setbright
    sleep 60; done # 5 min
}

function active() {
    eww update "listen_active=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"
    eww update "listen_prev=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')"
    eww update listen_switching=false

    echo line > "$dir/workspace-switching"

    local prev
    prev=""

    socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}' |
        while read -r active; do
            if [ "$active" != "$prev" ]; then
                eww update "listen_switching=true" "listen_prev=$prev" "listen_active=$active"

                prev="$active"

                sleep 0.2 && eww update "listen_switching=false" &
            fi
        done
}

net_vpn &
net_check &
vol &
bright &
active &

while true; do
    [ -n "$(cat "$dir/kill")" ] && eww kill && pkill -P $$ && sleep 0.1 && exit
sleep 0.3; done
''
