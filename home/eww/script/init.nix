/* bash */ ''
dir=/home/canoe/.config/eww/listen
mkdir -p "$dir"

function net_vpn() {
    echo > "$dir/net-vpn"

    while true; do
        protonvpn status | grep '^Status: ' | awk '{ print $2 }' \
        | grep -o '^.' | sed -e 's|C|v |' -e 's|D||' >> "$dir/net-vpn"

    sleep 5; done
}

function net_speed() {
    echo > "$dir/net-check"

    while true; do
        wget -q --spider http://google.com

        if [ $? -eq 0 ]; then
            echo "" > "$dir/net-check"
        else
            echo " -" > "$dir/net-check"
        fi

    sleep 5; done # 5 min
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
    hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id' > "$dir/active"

    socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
        stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}' >> "$dir/active"
}

setbright 100%
setvol 0%

net_vpn &
net_speed &
vol &
bright &
active &

eww open dock
''
