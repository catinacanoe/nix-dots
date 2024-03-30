{ pkgs, ... }:
let
    cases = /* bash */ ''
    case "$response" in
        h|help)
            echo
            echo "'vpnshell' interactive shell for proton vpn (please run as root)"
            echo
            echo "help | h"
            echo "    prints out this help menu with a list of commands"
            echo
            echo "connect | up | c | u"
            echo "    connects the vpn to the fastest server available"
            echo
            echo "choose | ch"
            echo "    allows the user to choose a vpn server, then connects to it"
            echo
            echo "disconnect | down | d"
            echo "    disconnects from the vpn server"
            echo
            echo "reload | restart | r"
            echo "    reloads the vpn connection"
            echo
            echo "status | s"
            echo "    prints out the current vpn status"
            echo
            echo "quit | q"
            echo "    quit this interactive shell"
            ;;
        connect|up|c|u) wg-quick up vpn ;;
        choose|ch) wg-quick up vpn ;; # can't pick and choose server :/
        disconnect|down|d) wg-quick down vpn ;;
        reload|restart|r) wg-quick down vpn && wg-quick up vpn ;;
        status|s) wg ;;
        q) exit ;;
        *) echo "command not found. access the help menu with 'help' or 'h'" ;;
    esac
    '';
in
pkgs.writeShellScriptBin "vpnshell" ''
if [ -n "$1" ]; then
    response="$1"

    ${cases}

    exit
fi

while true ; do
    printf "\033[0;35mvpn\033[0;31m > \033[0m"
    read response

    ${cases}

    echo
done
''
