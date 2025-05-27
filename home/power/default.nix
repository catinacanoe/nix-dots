{ pkgs, ... }:
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

    lock() { ${swaylock} --image="$(swww query | sed 's|^.*image: ||' | head -n 1)"; }

    case "$choice" in
        lock) delay && lock ;;
        ${if (import ../../ignore-hostname.nix) == "nixbox" then /*sh*/ ''
            suspend) lock && sleep 2 && systemctl suspend ;;
        '' else /*sh*/ ''
            suspend) delay && lock && delay && systemctl suspend ;;
        ''}
        reload) ${hyprctl} reload ;;
        logout) ${hyprctl} dispatch exit ;;
        cycle) reboot ;;
        shutdown) shutdown now ;;
    esac
    '')];
}
