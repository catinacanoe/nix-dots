{ ... }:
with (import ../../rice);
{
    programs.swaylock = {
        enable = true;
        settings = {
            daemonize = true;
            effect-blur = "7x5";
            effect-vignette = "0.5:0.5";

            font = font.name;
            font-size = "300";

            text-color = col.fg.hex;
            text-clear-color = col.bg.hex;
            text-ver-color = col.yellow.hex;
            text-wrong-color = col.red.hex;
            text-caps-lock-color = col.mg.hex;

            key-hl-color = col.fg.hex;
            bs-hl-color = col.bg.hex;
            caps-lock-key-hl-color = col.mg.hex;
            caps-lock-bs-hl-color = col.mg.hex;

            clock = true;
            timestr = "";
            datestr = "Locked";

            indicator = true;
            indicator-caps-lock = true;
            ignore-empty-password = true;
            disable-caps-lock-text = true;

            indicator-radius = "350";
            indicator-thickness = "12";

            separator-color = "00000000";
            inside-color = "00000000";
            inside-clear-color = "00000000";
            inside-caps-lock-color = "00000000";
            inside-ver-color = "00000000";
            inside-wrong-color = "00000000";

            ring-color = "00000000";
            ring-clear-color = "00000000";
            ring-caps-lock-color = "00000000";
            ring-ver-color = "00000000";
            ring-wrong-color = "00000000";

            line-color = "00000000";
            line-clear-color = "00000000";
            line-caps-lock-color = "00000000";
            line-ver-color = "00000000";
            line-wrong-color = "00000000";
        };
    };
}
