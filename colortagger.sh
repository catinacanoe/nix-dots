#!/usr/bin/env bash

file="$(find ~/mus/new/ -maxdepth 1 | sed -n 2p)"
[ -z "$file" ] && exit 1

mpdname="$(echo "$file" | sed "s|$XDG_MUSIC_DIR/||")"
echo "$mpdname"

mpc insert "$mpdname"
mpc single on
mpc play
mpc next

exit
name="$(echo "$splitfile" | head -n 1)"
name="$(basename "$name")"
tags="$(echo "$splitfile" | tail -n +2 | sed -e 's|^\(.\)-|\1=|' -e 's|_|-|g')"

finaltags=""

while IFS= read -r tag; do
    if echo "$tag" | grep -q '^l='; then
        if [ "$tag" == "l=0" ]; then
            tag="l=na"
        else

            options="$(grep '^l=' ~/mus/meta/tags | grep -v '^l=na$' | sed 's|^l=||' ; echo "What language is: $name")"
            response="$(echo "$options" | fzf --print-query | tail -n 1)"

            tag="l=$response"
        fi
    fi

    if grep -q "$tag" ~/mus/meta/tags; then true; else
        echo "$tag" >> ~/mus/meta/tags
        sort --output=~/mus/meta/tags ~/mus/meta/tags 
    fi

    finaltags="$(
    [ -n "$finaltags" ] && echo "$finaltags"
    echo "$tag"
    )"
done <<< "$tags"

finaltags="$(echo "$finaltags" | sort | tr '\n' ' ')"
index="$name /// $finaltags"

echo "$index"
echo "$index" >> "$XDG_MUSIC_DIR/meta/index"
mv -v "$file" "$XDG_MUSIC_DIR/new/$name"

mpc single off
