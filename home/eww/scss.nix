{ rice, hostname, ... }: /* scss */ ''
* {
    all: unset;
}

.dock-layout {
    color: ${rice.col.fg.h};
    background: rgba(0,0,0,0);
}

.dock-time { color: ${toString rice.col.green.h}; }
.dock-battery { color: ${toString rice.col.blue.h}; }
.dock-brightness { color: ${toString rice.col.yellow.h}; }
.dock-volume { color: ${toString rice.col.red.h}; }
.dock-net { color: ${toString rice.col.purple.h}; }

.dock-workspace-pad {
    background: rgba(0,0,0,0);
    padding-top: 10px;
}

.dock-workspaces {
    padding-top: 15px;
    border-radius: 9999px;
    background: ${rice.col.fg.h};

    margin-left: ${toString (4*rice.window.border)}px;
    margin-right: ${toString (4*rice.window.border)}px;

    animation-duration: 0.2s;
    animation-timing-function: ease-out;
}

@keyframes open {
    from { padding-right: 15px; }
    to   { padding-right: 40px; }
}

@keyframes close {
    from { padding-right: 40px; }
    to   { padding-right: 15px; }
}

@keyframes close-empty {
    from { padding-right: 36px; }
    to   { padding-right: 9px; }
}

.dock-workspaces.active.switching { animation-name: open; }
.dock-workspaces.occupied.switching { animation-name: close; }
.dock-workspaces.empty.switching { animation-name: close-empty; }

.dock-workspaces.active { padding-right: 40px; }
.dock-workspaces.occupied { padding-right: 15px; }
.dock-workspaces.empty {
    background: rgba(0,0,0,0);

    border-style: solid;
    border-width: 3px;
    border-color: ${rice.col.fg.h};

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
''
