{ mod, ...}:
let
    hypr = (import ../fn/hypr.nix);

    wsbind = { key, ws, pad ? "                " }: /* yaml */ ''
    # wsbind
    ${pad}${mod}-${key}:
        ${pad}${hypr "workspace ${ws}"}
    ${pad}${mod}-shift-${key}:
        ${pad}${hypr "movetoworkspace ${ws}"}
    # wsbind'';

    wsbindctrl = { key, ws, pad ? "                " }: /* yaml */ ''
    # wsbindctrl
    ${pad}${mod}-ctrl-${key}:
        ${pad}${hypr "movetoworkspacesilent ${ws}"}
    # wsbindctrl'';

    wsmon = { offset }: /* yaml */ ''
    # wsmon
                    ${wsbind { key = "r"; ws = "${offset}1"; }}
                    ${wsbindctrl { key = "r"; ws = "${offset}1"; }}

                    ${wsbind { key = "s"; ws = "${offset}2"; }}
                    ${wsbindctrl { key = "s"; ws = "${offset}2"; }}

                    ${wsbind { key = "t"; ws = "${offset}3"; }}
                    ${wsbindctrl { key = "t"; ws = "${offset}3"; }}

                    ${wsbind { key = "h"; ws = "${offset}4"; }}
                    ${mod}-esc:
                        ${hypr "movetoworkspacesilent ${offset}4"}

                    ${wsbind { key = "n"; ws = "${offset}5"; }}
                    ${mod}-left:
                        ${hypr "movetoworkspacesilent ${offset}5"}

                    ${wsbind { key = "a"; ws = "${offset}6"; }}
                    ${mod}-up:
                        ${hypr "movetoworkspacesilent ${offset}6"}

                    ${wsbind { key = "i"; ws = "${offset}7"; }}
                    ${mod}-down:
                        ${hypr "movetoworkspacesilent ${offset}7"}

                    ${wsbind { key = "o"; ws = "${offset}8"; }}
                    ${mod}-right:
                        ${hypr "movetoworkspacesilent ${offset}8"}
    # wsmon'';
in
/* yaml */ ''
# workspaces.nix
        ${wsbind { key = "c"; ws = "r-1"; pad = "        "; }}
        ${wsbind { key = "y"; ws = "r+1"; pad = "        "; }}
        ${wsbind { key = "f"; ws = "previous"; pad = "        "; }}

        ${mod}-h:
            remap:
                ${wsmon { offset = "0"; }}
        ${mod}-t:
            remap:
                ${wsmon { offset = "1"; }}
        ${mod}-s:
            remap:
                ${wsmon { offset = "2"; }}
        ${mod}-r:
            remap:
                ${wsmon { offset = "3"; }}
# workspaces.nix
''
