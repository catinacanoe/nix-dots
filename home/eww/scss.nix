{ rice, hostname, ... }: let
    music-gradient-opacity = "1";

    music-triple-gradient = left: middle: right: /* css */ ''
        .${left}-${middle}-${right} {
            background-image: linear-gradient(to bottom right, rgba(${rice.col."${left}".rgb}, ${music-gradient-opacity}), rgba(${rice.col."${middle}".rgb}, ${music-gradient-opacity}), rgba(${rice.col."${right}".rgb}, ${music-gradient-opacity}));
            ${ if middle=="bg" || middle=="t0" || middle=="t1" || middle=="t2"
            then "color: ${rice.col.fg.h};"
            else "color: ${rice.col.bg.h};" }
        }
        .${left}-${right} {
            background-image: linear-gradient(to bottom right, rgba(${rice.col."${left}".rgb}, ${music-gradient-opacity}), rgba(${rice.col."${right}".h}, ${music-gradient-opacity}));
            ${ if left=="bg" || right=="bg" || left=="t0" || right=="t0" || left=="t1" || right=="t1" || left=="t2" || right=="t2"
            then "color: ${rice.col.fg.h};"
            else "color: ${rice.col.bg.h};" }
        }
        .${left} {
            background-color: rgba(${rice.col."${right}".rgb}, ${music-gradient-opacity});
            ${ if left == "bg"
            then "color: ${rice.col.fg.h};"
            else "color: ${rice.col.bg.h};" }
        }
    '';

    music-triple-fill-right = left: middle: ''
    ${music-triple-gradient left middle "fg"}
    ${music-triple-gradient left middle "mg"}
    ${music-triple-gradient left middle "bg"}
    ${music-triple-gradient left middle "t0"}
    ${music-triple-gradient left middle "t1"}
    ${music-triple-gradient left middle "t2"}
    ${music-triple-gradient left middle "t3"}
    ${music-triple-gradient left middle "t4"}
    ${music-triple-gradient left middle "t5"}
    ${music-triple-gradient left middle "t6"}
    ${music-triple-gradient left middle "t7"}
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
    ${music-triple-fill-right left "t0"}
    ${music-triple-fill-right left "t1"}
    ${music-triple-fill-right left "t2"}
    ${music-triple-fill-right left "t3"}
    ${music-triple-fill-right left "t4"}
    ${music-triple-fill-right left "t5"}
    ${music-triple-fill-right left "t6"}
    ${music-triple-fill-right left "t7"}
    ${music-triple-fill-right left "red"}
    ${music-triple-fill-right left "orange"}
    ${music-triple-fill-right left "yellow"}
    ${music-triple-fill-right left "green"}
    ${music-triple-fill-right left "aqua"}
    ${music-triple-fill-right left "blue"}
    ${music-triple-fill-right left "purple"}
    ${music-triple-fill-right left "brown"}
    '';
in /* scss */ ''
* { all: unset; }

.dock-layout {
    color: ${rice.col.fg.h};
    background: rgba(0,0,0,0);
}

.dock-mus-progress,
.left {
    border-radius: 9999px;
    min-width: 6px; 
}
.left {
    background-image: linear-gradient(to bottom right, ${rice.col.mg.h}, ${rice.col.bg.h});
}
progressbar > trough {
    min-width: 60px;
    min-height: 6px;
    background: rgba(0,0,0,0);
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
    margin-left: ${toString (rice.window.gaps-in / 3)}px;
    margin-right: ${toString (rice.window.gaps-in / 3)}px;
}

${music-triple-fill-middle-right "fg"}
${music-triple-fill-middle-right "mg"}
${music-triple-fill-middle-right "bg"}
${music-triple-fill-middle-right "t0"}
${music-triple-fill-middle-right "t1"}
${music-triple-fill-middle-right "t2"}
${music-triple-fill-middle-right "t3"}
${music-triple-fill-middle-right "t4"}
${music-triple-fill-middle-right "t5"}
${music-triple-fill-middle-right "t6"}
${music-triple-fill-middle-right "t7"}
${music-triple-fill-middle-right "red"}
${music-triple-fill-middle-right "orange"}
${music-triple-fill-middle-right "yellow"}
${music-triple-fill-middle-right "green"}
${music-triple-fill-middle-right "aqua"}
${music-triple-fill-middle-right "blue"}
${music-triple-fill-middle-right "purple"}
${music-triple-fill-middle-right "brown"}
''
