{ ... }:
let
    rice = (import ../../rice);
    fontsize = rice.font.size;
    inherit (rice) col;
in
{
    services.mako = {
        enable = true;

        settings = {
            font = "monospace ${toString fontsize}";
            icons = false;
            actions = false;
            default-timeout = 7*1000; # millis
            ignore-timeout = false;
            layer = "overlay";
            anchor = "bottom-right";
            max-visible = -1;

            width = 400;
            height = 150;
            border-size = rice.window.border;
            border-radius = if rice.style.rounding then rice.window.radius else 0;
            margin = rice.window.gaps-out;
            outer-margin = "${toString (2*rice.window.gaps-out)},${toString rice.window.gaps-out}";
            padding = toString rice.window.gaps-in;

            text-color = "${col.fg.h}ff";
            border-color = "${col.fg.h}b0";
            background-color = "${col.bg.h}b0";
            progress-color = "${col.blue.h}ff";
        };
    };
}
