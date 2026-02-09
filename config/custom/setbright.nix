{ pkgs, ... }: pkgs.writeShellScriptBin "setbright" ''
if [ "$1" != "silent" ]; then
    [ -n "$1" ] && brightnessctl set "$1"
fi

bright="$(bc <<< "100*$(brightnessctl get)/64764")"
eww update "var_brightness=$bright"

if [ "$1" != "silent" ] && [ "$(hyprctl activeworkspace -j | jq .windows)" != 0 ] && [ "$(hyprctl activewindow -j | jq .fullscreen)" != 0 ]; then
    makoctl dismiss --all
    battery="$(eww state | grep '^var_battery: ' | sed -e 's|^[^ ]* ||' -e 's| [^ ]*$||')"
    notify-send "brightness: $bright% (bat: $battery)" --expire-time=600
fi
''
