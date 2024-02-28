{ config, pkgs, ... }: pkgs.writeShellScriptBin "setbright" ''
[ -n "$1" ] && brightnessctl set "$1"
eww update "var_brightness=$(bc <<< "100*$(brightnessctl get)/255")"
''
