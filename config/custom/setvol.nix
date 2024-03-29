{ pkgs, ... }: pkgs.writeShellScriptBin "setvol" ''
[ -n "$1" ] && wpctl set-volume @DEFAULT_SINK@ "$1"
eww update "var_volume=$(wpctl get-volume @DEFAULT_SINK@ | sed -e 's|^Volume: ||' -e 's|\.||' -e 's|0*\(.\)|\1|')"
eww update "var_audio_device=$(wpctl status | awk '/Sink endpoints/{exit}; flag; /Sinks/{flag=1}' | grep ' \* ' | sed -e 's|^.*\* *[0-9]\+\. ||' -e 's| *\[vol.*$||' | grep -v 'Audio' | tr '[:upper:]' '[:lower:]' | grep -o '^..' | sed -e 's|^| (|' -e 's|$|)|')"
''
