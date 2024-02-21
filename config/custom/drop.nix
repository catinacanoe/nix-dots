{ pkgs, ... }: pkgs.writeShellScriptBin "drop" ''
LASTFILE="/tmp/pypr-drop-last.save"
CURRENTFILE="/tmp/pypr-drop-current.save"

[ -f "$LASTFILE" ] || touch "$LASTFILE"
[ -f "$CURRENTFILE" ] || touch "$CURRENTFILE"

last="$(cat "$LASTFILE")"
current="$(cat "$CURRENTFILE")"
alt="$2"

function hide() {
    hyprctl dispatch focuscurrentorlast &> /dev/null
    pypr hide "$1"

    echo "" > "$CURRENTFILE"
}

function show() {
    pypr show "$1"

    echo "$1" > "$CURRENTFILE"
    echo "$1" > "$LASTFILE"
}

if [ -z "$1" ]; then
    if [ -n "$current" ]; then
        hide "$current"
    else
        show "$last"
    fi
else
    if [ "$current" == "$1" ]; then
        hide "$current"
    elif [ -n "$current" ]; then
        [ -z "$alt" ] && hide "$current"
        show "$1"
    else
        show "$1"
    fi
fi
''
