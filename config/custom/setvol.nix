{ pkgs, ... }: pkgs.writeShellScriptBin "setvol" ''
if [ "$1" != "silent" ]; then
    [ -n "$1" ] && wpctl set-volume @DEFAULT_SINK@ "$1"
fi

vol="$(wpctl get-volume @DEFAULT_SINK@ | sed -e 's|^Volume: ||' -e 's|\.||' -e 's|0*\(.\)|\1|')"
eww update "var_volume=$vol"
eww update "var_audio_device=$(bluetoothctl devices Connected | sed -e 's|^[^ ]* [^ ]* ||' | tr '[:upper:]' '[:lower:]' | grep -o '^..' | sed -e 's|^| (|' -e 's|$|)|')"

if [ "$1" != "silent" ] && [ "$(hyprctl activeworkspace -j | jq .windows)" != 0 ] && [ "$(hyprctl activewindow -j | jq .fullscreen)" != 0 ]; then
    makoctl dismiss --all
    notify-send "volume: $vol%" --expire-time=600
fi
''
