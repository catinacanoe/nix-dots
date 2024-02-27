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
}

.dock-workspaces.active.switching { background: #0f0; }
.dock-workspaces.occupied.switching { background: #f00; }
.dock-workspaces.empty.switching { border-color: #f00; }

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
