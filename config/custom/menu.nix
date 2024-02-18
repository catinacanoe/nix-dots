{ pkgs, ... }: pkgs.writeShellScriptBin "drop" ''
FIFO="${(import ../../rice).menufifo}"

while true; do
    fzf < "$FIFO"
done
''
