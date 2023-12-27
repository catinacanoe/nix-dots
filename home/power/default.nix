# also configures swaylock
{ config, pkgs, ... }:
with (import ../../rice);
{
    home.packages = 
    let
        swaylock = "${pkgs.swaylock-effects}/bin/swaylock";
        hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    in
    [(pkgs.writeShellScriptBin "power" /*bash*/ ''
    options="$(echo 'lock_suspend_reload_tty_cycle_shutdown' | tr '_' '\n')"

    if [ -z "$1" ]; then
        # interactive menu
	choice="$(echo "$options" | $MENU)"
    else
        choice="$(echo "$options" | grep "^$1" | head -n 1)"
    fi

    delay() { sleep 0.2; }

    lock() { ${swaylock} --image="$(swww query | sed 's|^.*image: ||')" "$@"; }

    case "$choice" in
	lock) delay && lock --grace=0.5 ;;
	suspend) delay && lock && delay && systemctl suspend ;;
	reload) ${hyprctl} dispatch forcerendererreload ;;
	tty) ${hyprctl} kill ;;
        cycle) reboot ;;
        shutdown) shutdown now ;;
    esac
    '')];

    programs.swaylock = {
        enable = true;
        settings = {
	    daemonize = true;
            effect-blur = "7x5";
            effect-vignette = "0.5:0.5";

            font = font.name;
            font-size = "300";

            fade-in = "0.2";

            text-color = col.fg;
            text-clear-color = col.bg;
            text-ver-color = col.blue;
            text-wrong-color = col.purple;
            text-caps-lock-color = col.aqua;

            clock = true;
            timestr = "";
            datestr = "Locked";

            indicator = true;
            indicator-caps-lock = true;
            ignore-empty-password = true;
            disable-caps-lock-text = true;

            indicator-radius = "350";
            indicator-thickness = "12";

            key-hl-color = col.fg;
            bs-hl-color = col.bg;
            caps-lock-key-hl-color = col.aqua;
            caps-lock-bs-hl-color = col.aqua;

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
