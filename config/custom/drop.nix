{ pkgs, ... }: pkgs.writeShellScriptBin "drop" ''
LASTFILE="/tmp/pypr-drop-last.save"
CURRENTFILE="/tmp/pypr-drop-current.save"

last="$(cat "$LASTFILE")"
current="$(cat "$CURRENTFILE")"
alt="$2"

if [ "$1" == "init" ]; then
    echo > "$LASTFILE"
    echo > "$CURRENTFILE"
    exit
elif [ "$1" == "focus" ]; then
    [ -n "$current"] && pypr hide "$current" && pypr show "$current" && exit
fi

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
