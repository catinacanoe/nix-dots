#!/usr/bin/env bash

line="$(grep -v ' t=.' ~/mus/meta/index | head -n 1)"
[ -z "$line" ] && exit 1

name="$(echo "$line" | sed 's| /// .*$||')"

mpc insert "new/$name.mp3"
mpc single on
mpc play
mpc next

echo "" > /tmp/muscolorfile

function update() {
    while true; do
        col="$(cat /tmp/muscolorfile)"
        [ -n "$col" ] && eww update "var_mus_color=$col"
        sleep 0.1 
    done
}; update &

nvim /tmp/muscolorfile
newtag="t=$(cat /tmp/muscolorfile)"

mpc single off
sed -i "/^$name/s|$| $newtag|" ~/mus/meta/index

kill $(ps aux | grep 'bash ./colortagger.sh' | awk '{ print $2 }' | grep -v $$)
