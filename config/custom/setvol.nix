{ pkgs, ... }: pkgs.writeShellScriptBin "setvol" ''
[ -n "$1" ] && wpctl set-volume @DEFAULT_SINK@ "$1"
eww update "var_volume=$(wpctl get-volume @DEFAULT_SINK@ | sed -e 's|^Volume: ||' -e 's|\.||' -e 's|0*\(.\)|\1|')"
eww update "var_audio_device=$(bluetoothctl devices Connected | awk '{print $NF}' | tr '[:upper:]' '[:lower:]' | grep -o '^..' | sed -e 's|^| (|' -e 's|$|)|')"
''
