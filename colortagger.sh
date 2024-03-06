#!/usr/bin/env bash

TEST_FILE="/tmp/eww-test-color"

line="$(grep -v ' t=.' ~/mus/meta/index | head -n 1)"
[ -z "$line" ] && exit 1

name="$(echo "$line" | sed 's| /// .*$||')"

mpc insert "new/$name.mp3"
mpc single on
mpc play
mpc next

echo "" > "$TEST_FILE"
nvim "$TEST_FILE"
newtag="t=$(cat "$TEST_FILE")"
echo "" > "$TEST_FILE"

mpc single off
sed -i "/^$name/s|$| $newtag|" ~/mus/meta/index

kill $(ps aux | grep 'bash ./colortagger.sh' | awk '{ print $2 }' | grep -v $$)
