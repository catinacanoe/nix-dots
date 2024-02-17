{  pkgs, ... }:
with (import ../../rice).col;
{
    home.packages = [(pkgs.writeShellScriptBin "scrot" ''
        grim -g "$(slurp -d -b '${bg.h}90' -s '00000000' -w '0' -F 'VictorMono')" - > /tmp/grimshot.png
        cat /tmp/grimshot.png | wl-copy
        mv /tmp/grimshot.png "$XDG_PICTURES_DIR/grim/$(date +'%Y-%m-%d---%H-%M').png"
    '')];
}
