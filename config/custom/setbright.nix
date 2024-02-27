{ config, pkgs, ... }: pkgs.writeShellScriptBin "setbright" ''
[ -n "$1" ] && brightnessctl set "$1"
bc <<< "100*$(brightnessctl get)/255" >> /home/canoe/.config/eww/listen/brightness
''
