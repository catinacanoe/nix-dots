{ mod, ... }:
let
    launch = (import ../fn/launch.nix);

    vol-def      = "2%";
    bright-def   = "2%";
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

        ${mod}-5:
            ${launch "plyr prev"}
        ${mod}-ctrl-5:
            ${launch "plyr seek -5"}
        ${mod}-6:
            ${launch "plyr toggle"}
        ${mod}-ctrl-6:
            ${launch "plyr switch"}
        ${mod}-7:
            ${launch "mpc del 0"}
        ${mod}-ctrl-8:
            ${launch "plyr seek +5"}
        ${mod}-8:
            ${launch "plyr next"}

        ${mod}-4:
            ${launch "drop player"}
        ${mod}-3:
            ${launch "drop mtag"}

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
