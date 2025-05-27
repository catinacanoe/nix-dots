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
                    ${launchdir direction "browser new-window"}
                ${mod}-d:
                    ${launchdir direction "discord"}
                ${mod}-v:
                    ${launchdir direction "vimit"}
# programs.nix ${direction}
''
