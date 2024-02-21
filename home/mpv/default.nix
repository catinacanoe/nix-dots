{ config, ... }:
let
    font = (import ../../rice).font.name;
in {
    programs.mpv = {
        enable = true;
        bindings = {
            N = "seek -30";
            n = "seek -10";
            a = "seek -5";
            A = "seek -1";
            I = "seek +1";
            i = "seek +5";
            o = "seek +10";
            O = "seek +30";
            
            l = "set speed 1";
            TAB = "add speed 0.1";
            u = "add speed -0.1";

            e = "cycle sub";
            SPACE = "cycle pause";
            ";" = "quit";
        };

        config = {
            no-keepaspect-window = true;
            osd-font = font;
            sub-font = font;
        };
    };
}
