{ pkgs, ... }: pkgs.writeShellScriptBin "drop" ''
SAVEFILE="/tmp/pypr-last-drop.save"

if [ -z "$1" ]; then
    pypr toggle "$(cat "$SAVEFILE")"
else
    pypr toggle "$1"
    echo "$1" > "$SAVEFILE"
fi
''
