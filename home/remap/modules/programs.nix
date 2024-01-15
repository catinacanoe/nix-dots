{ direction, mod, ... }:
let
    launchdir = (import ../fn/launchdir.nix);
in
/* yaml */ ''
# programs.nix ${direction}
                ${mod}-space:
                    ${launchdir direction "echo"}
                ${mod}-t:
                    ${launchdir direction "kitty ~"}
                ${mod}-h:
                    ${launchdir direction "firefox --new-window about:blank"}
# programs.nix ${direction}
''
