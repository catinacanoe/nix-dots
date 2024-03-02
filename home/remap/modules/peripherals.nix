{ mod, ... }:
let
    launch = (import ../fn/launch.nix);

    vol-def      = "3%";
    bright-def   = "3%";
    vol-small    = "1%";
    bright-small = "1%";

    vol = incr: launch "setvol ${incr}";
    bright = incr: launch "setbright ${incr}";
in
/* yaml */ ''
# peripherals.nix
        # brightness keys are defined in hypr config b/c xremap is too stupid to catch them
        volumeup:
            ${vol "${vol-def}+"}
        volumedown:
            ${vol "${vol-def}-"}
        ctrl-volumeup:
            ${vol "${vol-small}+"}
        ctrl-volumedown:
            ${vol "${vol-small}-"}
        mute:
            ${vol "0"}

        ${mod}-shift-8: # asterisk
            ${vol "${vol-def}+"}
        ${mod}-slash:
            ${vol "${vol-def}-"}
        ${mod}-ctrl-shift-8:
            ${vol "${vol-small}+"}
        ${mod}-ctrl-slash:
            ${vol "${vol-small}-"}
        ${mod}-equal:
            ${vol "0"}

        ${mod}-shift-equal: # plus
            ${bright "${bright-def}+"}
        ${mod}-minus:
            ${bright "${bright-def}-"}
        ${mod}-ctrl-shift-equal:
            ${bright "${bright-small}+"}
        ${mod}-ctrl-minus:
            ${bright "${bright-small}-"}
        ${mod}-shift-minus:
            ${bright "0"}
# peripherals.nix
''
