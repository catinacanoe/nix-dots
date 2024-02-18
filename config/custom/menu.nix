{ pkgs, ... }: pkgs.writeShellScriptBin "menu" ''
FIFO="${(import ../../rice).menufifo}"

while true; do
    echo "awaiting input from fifo"
    input="$(cat "$FIFO")"
    args="$(echo "$input" | head -n 1)"
    list="$(echo "$input" | tail -n +2)"

    response="$(echo "$list" | fzf --print-query)"
    selected="$(echo "$response" | tail -n 1)"
    typed="$(echo "$response" | head -n 1)"

    if [ "$(echo "$response" | wc -l)" == "1" ]; then
    else
    fi
done
''
