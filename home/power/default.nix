# also configures swaylock
{ pkgs, ... }:
with (import ../../rice);
{
    home.packages = 
    let
        swaylock = "${pkgs.swaylock-effects}/bin/swaylock";
        hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    in
    [(pkgs.writeShellScriptBin "power" ''
    options="$(echo 'lock_suspend_reload_logout_cycle_shutdown' | tr '_' '\n')"

    if [ -z "$1" ]; then
        # interactive menu
        choice="$(echo "$options" | $DMENU_PROGRAM)"
    else
        choice="$(echo "$options" | grep "^$1" | head -n 1)"
    fi

    delay() { sleep 0.8; }

    lock() { ${swaylock} --image="$(swww query | sed 's|^.*image: ||')" "$@"; }

    case "$choice" in
        lock) delay && lock ;;
        ${if (import ../../ignore-hostname.nix) == "nixbox" then ''
            suspend) lock && sleep 2 && systemctl suspend ;;
        '' else ''
            suspend) delay && lock && delay && systemctl suspend ;;
        ''}
        reload) ${hyprctl} dispatch forcerendererreload ;;
        logout) ${hyprctl} dispatch exit ;;
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

            text-color = col.fg.hex;
            text-clear-color = col.purple.hex;
            text-ver-color = col.yellow.hex;
            text-wrong-color = col.red.hex;
            text-caps-lock-color = col.aqua.hex;

            clock = true;
            timestr = "";
            datestr = "Locked";

            indicator = true;
            indicator-caps-lock = true;
            ignore-empty-password = true;
            disable-caps-lock-text = true;

            indicator-radius = "350";
            indicator-thickness = "12";

            key-hl-color = col.fg.hex;
            bs-hl-color = col.purple.hex;
            caps-lock-key-hl-color = col.aqua.hex;
            caps-lock-bs-hl-color = col.aqua.hex;

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
