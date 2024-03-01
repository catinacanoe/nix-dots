{ rice, hostname, ... }: let
    music-gradient-opacity = "0.85";

    music-single-col = col: /* css */ ''
        .dock-block.music.${col} {
            background-color: rgba(${rice.col."${col}".rgb}, ${music-gradient-opacity});
            ${ if col == "bg"
            then "color: ${rice.col.fg.h};"
            else "color: ${rice.col.bg.h};" }
        }
    '';

    music-double-gradient = left: right: /* css */ ''
        .dock-block.music.${left}-${right} {
            background-image: linear-gradient(to bottom right, rgba(${rice.col."${left}".rgb}, ${music-gradient-opacity}), rgba(${rice.col."${right}".h}, ${music-gradient-opacity}));
            ${ if left=="bg" || right=="bg"
            then "color: ${rice.col.fg.h};"
            else "color: ${rice.col.bg.h};" }
        }
    '';
    music-double-fill-right = left: ''
    ${music-double-gradient left "fg"}
    ${music-double-gradient left "mg"}
    ${music-double-gradient left "bg"}
    ${music-double-gradient left "red"}
    ${music-double-gradient left "orange"}
    ${music-double-gradient left "yellow"}
    ${music-double-gradient left "green"}
    ${music-double-gradient left "aqua"}
    ${music-double-gradient left "blue"}
    ${music-double-gradient left "purple"}
    ${music-double-gradient left "brown"}
    '';

    music-triple-gradient = left: middle: right: /* css */ ''
        .dock-block.music.${left}-${middle}-${right} {
            background-image: linear-gradient(to bottom right, rgba(${rice.col."${left}".rgb}, ${music-gradient-opacity}), rgba(${rice.col."${middle}".rgb}, ${music-gradient-opacity}), rgba(${rice.col."${right}".rgb}, ${music-gradient-opacity}));
            ${ if left=="bg" || middle=="bg" || right=="bg"
            then "color: ${rice.col.fg.h};"
            else "color: ${rice.col.bg.h};" }
        }
    '';
    music-triple-fill-right = left: middle: ''
    ${music-triple-gradient left middle "fg"}
    ${music-triple-gradient left middle "mg"}
    ${music-triple-gradient left middle "bg"}
    ${music-triple-gradient left middle "red"}
    ${music-triple-gradient left middle "orange"}
    ${music-triple-gradient left middle "yellow"}
    ${music-triple-gradient left middle "green"}
    ${music-triple-gradient left middle "aqua"}
    ${music-triple-gradient left middle "blue"}
    ${music-triple-gradient left middle "purple"}
    ${music-triple-gradient left middle "brown"}
    '';
    music-triple-fill-middle-right = left: ''
    ${music-triple-fill-right left "fg"}
    ${music-triple-fill-right left "mg"}
    ${music-triple-fill-right left "bg"}
    ${music-triple-fill-right left "red"}
    ${music-triple-fill-right left "orange"}
    ${music-triple-fill-right left "yellow"}
    ${music-triple-fill-right left "green"}
    ${music-triple-fill-right left "aqua"}
    ${music-triple-fill-right left "blue"}
    ${music-triple-fill-right left "purple"}
    ${music-triple-fill-right left "brown"}
    '';

    bg-grad = left: right: /* css */ ''
        { background-image: linear-gradient(to bottom right, ${rice.col."${left}".h}, ${rice.col."${right}".h}); }
    '';
in /* scss */ ''
* { all: unset; }

.dock-layout {
    color: ${rice.col.fg.h};
    background: rgba(0,0,0,0);
}

.dock-time { color: ${toString rice.col.green.h}; }
.dock-battery { color: ${toString rice.col.blue.h}; }
.dock-brightness { color: ${toString rice.col.yellow.h}; }
.dock-volume { color: ${toString rice.col.red.h}; }
.dock-net { color: ${toString rice.col.purple.h}; }

.dock-mus-progress, .left {
    border-radius: 9999px;
    background: rgba(${rice.col.bg.rgb}, 0.6);
}
.left { min-width: 6px; }
progressbar > trough {
    min-width: 60px;
    min-height: 6px;
}

.dock-workspace-pad {
    background: rgba(0,0,0,0);
    padding-top: 10px;
}

.dock-workspaces {
    border-radius: 9999px;
    padding-top: 15px;

    margin-left: ${toString (4*rice.window.border)}px;
    margin-right: ${toString (4*rice.window.border)}px;

    animation-duration: 0.15s;
    animation-timing-function: ease-out;
}

@keyframes open {
    from { padding-right: 16px; } /* adding one pixel seems to stablize the animation idk */
    to   { padding-right: 41px; }
}

@keyframes close {
    from { padding-right: 40px; }
    to   { padding-right: 15px; }
}

.dock-workspaces.active.switching { animation-name: open; }
.dock-workspaces.occupied.switching, .dock-workspaces.empty.switching { animation-name: close; }

.dock-workspaces.active {
    padding-right: 40px;
}
.dock-workspaces.occupied {
    padding-right: 15px;
}
.dock-workspaces.empty {
    padding-right: 15px;
    padding-top: 9px;

    margin-top: 3px;
    margin-bottom: 3px;
}

.dock-block {
    border-radius: ${toString rice.window.radius}px;
    background: rgba(${rice.col.bg.rgb}, 0.7);
    padding-left: ${toString (rice.window.radius)}px;
    padding-right: ${toString (rice.window.radius)}px;
}

.dock-widget {
    margin-left: ${toString rice.window.gaps-in}px;
    margin-right: ${toString rice.window.gaps-in}px;
}

.dock-workspaces.n5 ${bg-grad "red" "brown"}
.dock-workspaces.n4 ${bg-grad "red" "purple"}
.dock-workspaces.n3 ${bg-grad "blue" "purple"}
.dock-workspaces.n2 ${bg-grad "blue" "aqua"}
.dock-workspaces.n1 ${bg-grad "fg" "t2"}
.dock-workspaces.n0 ${bg-grad "mg" "t2"}

${music-single-col "fg"}
${music-single-col "mg"}
${music-single-col "bg"}
${music-single-col "red"}
${music-single-col "orange"}
${music-single-col "yellow"}
${music-single-col "green"}
${music-single-col "aqua"}
${music-single-col "blue"}
${music-single-col "purple"}
${music-single-col "brown"}

${music-double-fill-right "fg"}
${music-double-fill-right "mg"}
${music-double-fill-right "bg"}
${music-double-fill-right "red"}
${music-double-fill-right "orange"}
${music-double-fill-right "yellow"}
${music-double-fill-right "green"}
${music-double-fill-right "aqua"}
${music-double-fill-right "blue"}
${music-double-fill-right "purple"}
${music-double-fill-right "brown"}

${music-triple-fill-middle-right "fg"}
${music-triple-fill-middle-right "mg"}
${music-triple-fill-middle-right "bg"}
${music-triple-fill-middle-right "red"}
${music-triple-fill-middle-right "orange"}
${music-triple-fill-middle-right "yellow"}
${music-triple-fill-middle-right "green"}
${music-triple-fill-middle-right "aqua"}
${music-triple-fill-middle-right "blue"}
${music-triple-fill-middle-right "purple"}
${music-triple-fill-middle-right "brown"}
''
