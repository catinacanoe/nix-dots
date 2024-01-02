{ mod, ...}:
let
    hypr = (import ../fn/hypr.nix);
    resize = "50";
in
/* yaml */ ''
# windows.nix
        ${mod}-space:
            ${hypr "animatefocused"}

        ${mod}-m:
            ${hypr "togglesplit"}
        ${mod}-shift-m:
            ${hypr "fullscreen"}
        ${mod}-ctrl-m:
            ${hypr "togglefloating"}

        ${mod}-n:
            ${hypr "movefocus l"}
        ${mod}-a:
            ${hypr "movefocus u"}
        ${mod}-i:
            ${hypr "movefocus d"}
        ${mod}-o:
            ${hypr "movefocus r"}

        ${mod}-ctrl-n:
            ${hypr "resizeactive -${resize} 0"}
        ${mod}-ctrl-a:
            ${hypr "resizeactive 0 -${resize}"}
        ${mod}-ctrl-i:
            ${hypr "resizeactive 0 ${resize}"}
        ${mod}-ctrl-o:
            ${hypr "resizeactive ${resize} 0"}

        ${mod}-shift-n:
            ${hypr "swapwindow l && hyprctl dispatch moveactive -${resize} 0"}
        ${mod}-shift-a:
            ${hypr "swapwindow u && hyprctl dispatch moveactive 0 -${resize}"}
        ${mod}-shift-i:
            ${hypr "swapwindow d && hyprctl dispatch moveactive 0 ${resize}"}
        ${mod}-shift-o:
            ${hypr "swapwindow r && hyprctl dispatch moveactive ${resize} 0"}

        ${mod}-shift-l:
            ${hypr "movewindow l"}
        ${mod}-shift-tab:
            ${hypr "movewindow u"}
        ${mod}-shift-u:
            ${hypr "movewindow d"}
        ${mod}-shift-q:
            ${hypr "movewindow r"}
# windows.nix
''
