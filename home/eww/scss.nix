{ rice, hostname, ... }: 
let
    # ws_border = rice.window.border;
    ws_border = 0;
    ws_short = 11 - 2*ws_border; /* must be odd */
    ws_long = 30 - 2*ws_border;
    ws_spacing = 4*rice.window.border;
in /* scss */ ''
* {
    all: unset;
    font-size: ${toString rice.bar.fontsize}px;
}

.dock-layout {
    color: ${rice.col.fg.h};
    background: rgba(0,0,0,0);
}

.dock-mus-cava {
    font-size: ${toString (rice.bar.fontsize / rice.bar.cava.height)}px;
}

.dock-mus-progress, /* #####******====-----  */
.left {
    border-radius: 9999px;
    min-width: 6px; 
}
.left {
    background: ${rice.col.fg.h};
}
.dock-mus-progress {
    background: rgba(${rice.col.fg.rgb}, 0.3);
}
progressbar > trough {
    min-width: 60px;
    min-height: 6px;
    background: rgba(0,0,0,0);
}

.dock-workspace-pad {
    background: rgba(0,0,0,0);
    padding-top: ${toString ( (rice.bar.height - ws_short - 2*ws_border) / 2)}px;
}

.dock-workspaces {
    border-radius: 9999px;
    padding-top: ${toString ws_short}px;

    margin-left: ${toString ws_spacing}px;
    margin-right: ${toString ws_spacing}px;

    border-style: solid;
    border-width: ${toString ws_border}px;

    animation-duration: 0.15s;
    animation-timing-function: ease-out;
}

/* .glass_col { background: rgba(${rice.col.fg.rgb}, 0.15); } at this point not used at all (only dark_col is used) */
.dark_col  { background: rgba(${rice.col.bg.rgb}, 0.5); }

.populated_ws {
    border-color: rgba(${rice.col.fg.rgb}, 1);
    background:   rgba(${rice.col.fg.rgb}, 1);
}
.empty_ws {
    border-color: rgba(${rice.col.fg.rgb}, 0.3);
    background:   rgba(${rice.col.fg.rgb}, 0.3);
}

@keyframes open {
    from { padding-right: ${toString (ws_short+1)}px; } /* adding one pixel seems to stablize the animation idk */
    to   { padding-right: ${toString (ws_long+1)}px; }
}

@keyframes close {
    from { padding-right: ${toString (ws_long)}px; }
    to   { padding-right: ${toString (ws_short)}px; }
}

.dock-workspaces.active.switching { animation-name: open; }
.dock-workspaces.occupied.switching, .dock-workspaces.empty.switching { animation-name: close; }

.dock-workspaces.active {
    padding-right: ${toString ws_long}px;
}
.dock-workspaces.empty,
.dock-workspaces.occupied {
    padding-right: ${toString ws_short}px;
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
