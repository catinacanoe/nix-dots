{ mod, ... }:
let
    launch = (import ../fn/launch.nix);
    hypr = (import ../fn/hypr.nix);
in
/* yaml */ ''
# power.nix
                ${mod}-n:
                    ${hypr "killactive"}
                ${mod}-semicolon:
                    ${launch "power"}
                ${mod}-l:
                    ${launch "power lock"}
                ${mod}-s:
                    ${launch "power suspend"}
                ${mod}-r:
                    ${launch "power reload"}
        ${mod}-shift-ctrl-semicolon:
            ${hypr "exit"}
# power.nix
''
