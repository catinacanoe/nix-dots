{ rice, hostname, ... }: /* scss */ ''
* { all: unset; }

* {
    border-color: rgba(0,0,0,0);
}

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
    background: ${rice.col.fg.h};
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

/* .glass_col { background: rgba(${rice.col.fg.rgb}, 0.15); } /* at this point not used at all (only dark_col is used)*/
.dark_col  { background: rgba(${rice.col.bg.rgb}, 0.5); }

.populated_ws { background: rgba(${rice.col.bg.rgb}, 0.8); }
.empty_ws     { background: rgba(${rice.col.bg.rgb}, 0.4); }

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
.dock-workspaces.empty,
.dock-workspaces.occupied {
    padding-right: 15px;
}

.dock-block {
    border-radius: ${toString (rice.window.radius + 2)}px;
    padding-left: ${toString (rice.window.radius)}px;
    padding-right: ${toString (rice.window.radius)}px;
}

.dock-widget {
    margin-left: ${toString (rice.window.gaps-in / 3)}px;
    margin-right: ${toString (rice.window.gaps-in / 3)}px;
}

/* autogen */ .t3-bg {
    background-image: linear-gradient(to bottom right, ${rice.col.t3.h}, ${rice.col.bg.h});
    color: ${rice.col.bg.h};
}

/* autogen */ .fg-bg {
    background-image: linear-gradient(to bottom right, ${rice.col.fg.h}, ${rice.col.bg.h});
    color: ${rice.col.bg.h};
}
''
