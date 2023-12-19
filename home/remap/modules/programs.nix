{ direction, mod, ... }:
let
    launchdir = (import ../fn/launchdir.nix);
in
''
# programs.nix ${direction}
                ${mod}-space:
                    ${launchdir direction "echo"}
                ${mod}-t:
                    ${launchdir direction "kitty ~"}
                ${mod}-h:
                    ${launchdir direction "firefox"}
# programs.nix ${direction}
''
