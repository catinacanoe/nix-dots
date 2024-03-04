#!/usr/bin/env bash

file="$(find ~/mus/ -maxdepth 1 -name '*.mp3' | head -n 1)"
splitfile="$(echo "$file" | sed 's|} {|\n|g' | sed 's| {|\n|' | sed 's|}.mp3$||')"
name="$(echo "$splitfile" | head -n 1)"
name="$(basename "$name")"
tags="$(echo "$splitfile" | tail -n +2)"

echo "$name"
echo
echo "$tags"
