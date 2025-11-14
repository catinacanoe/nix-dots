{ mod, ...}:
let
    hypr = (import ../fn/hypr.nix);
    resize = "50";
    resize-small = "10";
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

        ${mod}-left:
            ${hypr "resizeactive -${resize} 0"}
        ${mod}-up:
            ${hypr "resizeactive 0 -${resize}"}
        ${mod}-down:
            ${hypr "resizeactive 0 ${resize}"}
        ${mod}-right:
            ${hypr "resizeactive ${resize} 0"}

        ${mod}-shift-left:
            ${hypr "resizeactive -${resize-small} 0"}
        ${mod}-shift-up:
            ${hypr "resizeactive 0 -${resize-small}"}
        ${mod}-shift-down:
            ${hypr "resizeactive 0 ${resize-small}"}
        ${mod}-shift-right:
            ${hypr "resizeactive ${resize-small} 0"}

        # moveactive is for floating windows (doesn't affect non floating)
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
            ${hypr "movewindow mon:1"} # because windows arent often moved up and down, except between monitors
        ${mod}-shift-u:
            ${hypr "movewindow mon:0"}
        ${mod}-shift-q:
            ${hypr "movewindow r"}
# windows.nix
''
