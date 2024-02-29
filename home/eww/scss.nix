{ rice, hostname, ... }: let
    music-gradient = left: right: /* css */ ''
        .dock-block.music.${right}-${left},
        .dock-block.music.${left}-${right} {
            background-image: linear-gradient(to bottom right, rgba(${rice.col."${left}".rgb}, 0.85), rgba(${rice.col."${right}".h}, 0.85));
            color: ${rice.col.bg.h};
        }
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
    padding-top: 15px;
    border-radius: 9999px;

    margin-left: ${toString (4*rice.window.border)}px;
    margin-right: ${toString (4*rice.window.border)}px;

    animation-duration: 0.2s;
    animation-timing-function: ease-out;
}

.dock-workspaces.n5 ${bg-grad "red" "brown"}
.dock-workspaces.n4 ${bg-grad "red" "purple"}
.dock-workspaces.n3 ${bg-grad "blue" "purple"}
.dock-workspaces.n2 ${bg-grad "blue" "aqua"}
.dock-workspaces.n1 ${bg-grad "fg" "bg"}
.dock-workspaces.n0 ${bg-grad "mg" "mg"}

@keyframes open {
    from { padding-right: 15px; }
    to   { padding-right: 40px; }
}

@keyframes close {
    from { padding-right: 40px; }
    to   { padding-right: 15px; }
}

@keyframes close-empty {
    from { padding-right: 34px; }
    to   { padding-right: 9px; }
}

.dock-workspaces.active.switching { animation-name: open; }
.dock-workspaces.occupied.switching { animation-name: close; }
.dock-workspaces.empty.switching { animation-name: close-empty; }

.dock-workspaces.active { padding-right: 40px; }
.dock-workspaces.occupied { padding-right: 15px; }
.dock-workspaces.empty.n0 {
    background: rgba(0,0,0,0);

    border-style: solid;
    border-width: 3px;
    border-color: ${rice.col.mg.h};

    padding-right: 9px;
    padding-top: 10px;
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

${music-gradient "mg" "mg"}
${music-gradient "mg" "fg"}
${music-gradient "mg" "bg"}
${music-gradient "mg" "red"}
${music-gradient "mg" "orange"}
${music-gradient "mg" "yellow"}
${music-gradient "mg" "green"}
${music-gradient "mg" "aqua"}
${music-gradient "mg" "blue"}
${music-gradient "mg" "purple"}
${music-gradient "mg" "brown"}

${music-gradient "fg" "fg"}
${music-gradient "fg" "bg"}
${music-gradient "fg" "red"}
${music-gradient "fg" "orange"}
${music-gradient "fg" "yellow"}
${music-gradient "fg" "green"}
${music-gradient "fg" "aqua"}
${music-gradient "fg" "blue"}
${music-gradient "fg" "purple"}
${music-gradient "fg" "brown"}

${music-gradient "bg" "bg"}
${music-gradient "bg" "red"}
${music-gradient "bg" "orange"}
${music-gradient "bg" "yellow"}
${music-gradient "bg" "green"}
${music-gradient "bg" "aqua"}
${music-gradient "bg" "blue"}
${music-gradient "bg" "purple"}
${music-gradient "bg" "brown"}

${music-gradient "red" "red"}
${music-gradient "red" "orange"}
${music-gradient "red" "yellow"}
${music-gradient "red" "green"}
${music-gradient "red" "aqua"}
${music-gradient "red" "blue"}
${music-gradient "red" "purple"}
${music-gradient "red" "brown"}

${music-gradient "orange" "orange"}
${music-gradient "orange" "yellow"}
${music-gradient "orange" "green"}
${music-gradient "orange" "aqua"}
${music-gradient "orange" "blue"}
${music-gradient "orange" "purple"}
${music-gradient "orange" "brown"}

${music-gradient "yellow" "yellow"}
${music-gradient "yellow" "green"}
${music-gradient "yellow" "aqua"}
${music-gradient "yellow" "blue"}
${music-gradient "yellow" "purple"}
${music-gradient "yellow" "brown"}

${music-gradient "green" "green"}
${music-gradient "green" "aqua"}
${music-gradient "green" "blue"}
${music-gradient "green" "purple"}
${music-gradient "green" "brown"}

${music-gradient "aqua" "aqua"}
${music-gradient "aqua" "blue"}
${music-gradient "aqua" "purple"}
${music-gradient "aqua" "brown"}

${music-gradient "blue" "blue"}
${music-gradient "blue" "purple"}
${music-gradient "blue" "brown"}

${music-gradient "purple" "purple"}
${music-gradient "purple" "brown"}

${music-gradient "brown" "brown"}
''
