#!/usr/bin/env bash

function block() {
    local name="$1"
    local hex="$2"
    local r g b r0 b0 g0

    r="$(printf "%d" "0x${hex:0:2}")"
    g="$(printf "%d" "0x${hex:2:2}")"
    b="$(printf "%d" "0x${hex:4:2}")"
    r0="0$(bc <<< "scale = 3; $r / 255")"
    b0="0$(bc <<< "scale = 3; $b / 255")"
    g0="0$(bc <<< "scale = 3; $g / 255")"

    local dyeout
    dyeout="$(dye -x hsl "#$hex")"
    local h s l

    h="$(echo "$dyeout" | sed -e 's/^hsla(//' -e 's/, .*//')"
    s="$(echo "$dyeout" | sed -e 's/^hsla([^,]*, //' -e 's/%, .*//')"
    l="$(echo "$dyeout" | sed -e 's/^hsla([^%]*%, //' -e 's/%)$//')"

    echo "    $name = {"
    echo "        hex = \"$hex\"; h = \"#$hex\";"
    echo "        r = $r; g = $g; b = $b;"
    echo "        r0 = $r0; g0 = $g0; b0 = $b0;"
    echo "        rgb = \"$r, $g, $b\";"
    echo "        rgb0 = \"$r0 $g0 $b0\";"
    echo "        hu = $h; sa = $s; va = $l;"
    echo "    };"
}

in="$1"
[ -z "$in" ] && echo "please enter a colorscheme to generate" && exit
[ -f "$in" ] && in="$(basename "$in")"

out="$(

echo "{"
while read line; do
    name="${line// */}"
    hex="${line//* /}"

    [ -z "$name" ] && continue
    [ -z "$hex" ] && continue

    block "$name" "$hex"

    [ "$name" == "t0" ] && block "bg" "$hex"
    [ "$name" == "t4" ] && block "mg" "$hex"
    [ "$name" == "t7" ] && block "fg" "$hex"
done < "./src/$in"
echo "}"

)"

echo "$out" > "./out/$in.nix"
