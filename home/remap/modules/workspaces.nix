{ mod, ...}:
let
    hypr = (import ../fn/hypr.nix);
    rice = (import ../../../rice);

    hypr-movetomon = cmd: mon: (hypr "${cmd} && hyprctl dispatch movecurrentworkspacetomonitor ${mon}");

    wsbind = { key, ws, mon, pad ? "                " }: /* yaml */ ''
    # wsbind
    ${pad}${mod}-${key}:
        ${pad}${hypr-movetomon "workspace ${ws}" mon}
    ${pad}${mod}-shift-${key}:
        ${pad}${hypr-movetomon "movetoworkspace ${ws}" mon}
    ${pad}${mod}-ctrl-${key}:
        ${pad}${hypr-movetomon "movetoworkspacesilent ${ws}" mon}
    # wsbind'';

    wsmon = { offset, mon }: /* yaml */ ''
    # wsmon
                    ${wsbind { key = "r"; ws = "${offset}1"; inherit mon; }}
                    ${wsbind { key = "s"; ws = "${offset}2"; inherit mon; }}
                    ${wsbind { key = "t"; ws = "${offset}3"; inherit mon; }}
                    ${wsbind { key = "h"; ws = "${offset}4"; inherit mon; }}
                    ${wsbind { key = "n"; ws = "${offset}5"; inherit mon; }}
                    ${wsbind { key = "a"; ws = "${offset}6"; inherit mon; }}
                    ${wsbind { key = "i"; ws = "${offset}7"; inherit mon; }}
                    ${wsbind { key = "o"; ws = "${offset}8"; inherit mon; }}

                    ${mod}-esc: # for keyboard which has some ctrl-key combos mapped to other inputs
                        ${hypr-movetomon "movetoworkspacesilent ${offset}4" mon}

                    ${mod}-left: # for keyboard which has some ctrl-key combos mapped to other inputs
                        ${hypr-movetomon "movetoworkspacesilent ${offset}5" mon}

                    ${mod}-up: # for keyboard which has some ctrl-key combos mapped to other inputs
                        ${hypr-movetomon "movetoworkspacesilent ${offset}6" mon}

                    ${mod}-down: # for keyboard which has some ctrl-key combos mapped to other inputs
                        ${hypr-movetomon "movetoworkspacesilent ${offset}7" mon}

                    ${mod}-right: # for keyboard which has some ctrl-key combos mapped to other inputs
                        ${hypr-movetomon "movetoworkspacesilent ${offset}8" mon}
    # wsmon'';
in
/* yaml */ ''
# workspaces.nix
        ${wsbind { key = "c"; ws = "r-1"; pad = "        "; mon = "current"; }}
        ${wsbind { key = "y"; ws = "r+1"; pad = "        "; mon = "current"; }}
        ${wsbind { key = "f"; ws = "previous"; pad = "        "; mon = "current"; }}

        ${mod}-h:
            remap:
                ${wsmon { offset = "0"; mon = rice.monitor.primary.port; }}
        ${mod}-t:
            remap:
                ${wsmon { offset = "1"; mon = rice.monitor.secondary.port; }}
        ${mod}-s:
            remap:
                ${wsmon { offset = "2"; mon = "";}}
        ${mod}-r:
            remap:
                ${wsmon { offset = "3"; mon = "";}}
# workspaces.nix
''
