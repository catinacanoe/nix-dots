{ pkgs, ... }: pkgs.writeShellScriptBin "browse" ''
current_ws="$(hyprctl activeworkspace -j | jq .id)"
has_browser="$(hyprctl clients -j | jq "map(if .workspace.id == $current_ws then .class else null end) | contains([\"$BROWSER\"])")"

if [ "$has_browser" == "true" ]; then
    $BROWSER $@
else
    $BROWSER --new-window $@
fi
''
