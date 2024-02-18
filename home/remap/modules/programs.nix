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
                    ${launchdir direction "firefox -P main --new-window about:blank"}
                ${mod}-d:
                    ${launchdir direction "discord --enable-features=UseOzonePlatform --ozone-platform=wayland"}
# programs.nix ${direction}
''
