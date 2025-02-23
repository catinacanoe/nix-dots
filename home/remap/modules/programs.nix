{ direction, mod, ... }:
let
    launchdir = (import ../fn/launchdir.nix);
in
/* yaml */ ''
# programs.nix ${direction}
                ${mod}-space:
                    ${launchdir direction "echo"}
                ${mod}-l:
                    ${launchdir direction "kitty launcher"}
                ${mod}-t:
                    ${launchdir direction "kitty ~"}
                ${mod}-h:
                    ${launchdir direction "firefox -P main --new-window"}
                ${mod}-d:
                    ${launchdir direction "discord"}
                ${mod}-v:
                    ${launchdir direction "vimit"}
                ${mod}-w:
                    ${launchdir direction "firefox -P main --new-window && sleep 0.7 && pypr show browseshell"}
# programs.nix ${direction}
''
