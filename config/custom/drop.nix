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
    if [ "$(hyprctl activewindow -j | jq .floating)" == "true" ]; then
        hyprctl dispatch cyclenext
    else
        [ -z "$current" ] && exit
        hyprctl dispatch focuswindow floating
    fi
    exit
fi

function hide() {
    # only focus last if dropdown is focused AND there are other windows in the workspace (so that refocusing wont change the workspace)
    numwindows="$(hyprctl activeworkspace -j | jq .windows)"
    focusid="$(hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:scratch_$1\") | .focusHistoryID")"

    [ $numwindows -gt 1 ] && [ $focusid == 0 ] && hyprctl dispatch focuscurrentorlast &> /dev/null

    pypr hide "$1"

    echo > "$CURRENTFILE"
}

function show() {
    drop_mon="$(hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:scratch_$1\") | .monitor")"
    current_mon="$(hyprctl activeworkspace -j | jq .monitorID)"

    # drop_mon will be empty if this dropdown has never opened before (in which case we simply open it)
    if [ -z "$drop_mon" ] || [ "$drop_mon" == "$current_mon" ]; then
        pypr show "$1"
    else
        # if the drop is on another monitor we need to cycle it once before opening (for it to position correctly)
        hyprctl keyword animations:enabled false # to prevent visual annoyance
        pypr show "$1"
        pypr hide "$1"
        pypr show "$1"
        hyprctl keyword animations:enabled true
    fi

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
