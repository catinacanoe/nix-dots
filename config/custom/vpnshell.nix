{ pkgs, ... }: let col = import ./.shellcol.nix; in pkgs.writeShellScriptBin "vpnshell" ''
function printhelp() {
    echo "'vpnshell' interactive shell for proton vpn (please run as root)"
    echo
    echo "help | h"
    echo "    prints out this help menu with a list of commands"
    echo
    echo "connect | up | c | u"
    echo "    connects the vpn to the fastest server available"
    echo
    echo "disconnect | down | d"
    echo "    disconnects from the vpn server"
    echo
    echo "reload | restart | r"
    echo "    reloads the vpn connection"
    echo
    echo "quit | q"
    echo "    quit this interactive shell"
}

function current() {
    sudo wg show | grep '^interface:' | head -n 1 | sed 's|^interface: ||'
}

function list() {
    ls /etc/wireguard/ | sed 's|\.conf$||'
}

function connect_to() {
    echo "connecting to $1 ..."
    wg-quick up "$1"
}

function connect_pattern() {
    selection="$(list | grep -i "^$1" | head -n 1)"
    [ -z "$selection" ] && echo "failed to find connection matching search pattern '^$1'" && return

    connect_to "$selection"
}

function connect_menu() {
    selection="$(list | fzf)"
    [ -z "$selection" ] && echo "no selection" && return

    connect_to "$selection"
}

function disconnect_from() {
    echo "disconnecting from $1 ..."
    wg-quick down "$1"
}

function disconnect_auto() {
    selection="$(current)"
    [ -z "$selection" ] && echo "no interface currently active" && return
    disconnect_from "$selection"
}

function reload() {
    selection="$(current)"

    echo "reloading $selection ..."
    disconnect_from "$selection"
    connect_to "$selection"
}

function handle_response() {
    action="$(echo "$response" | awk '{ print $1 }')"
    arguments="$(echo "$response" | sed -e 's|^[^ ]*||' -e 's|^ *||')"

    case "$action" in
        'quit'|'q'|':q'|'z') exit ;;
        'help'|'h') printhelp ;;
        'active'|'a') current ;;
        'list'|'l') list ;;
        'up'|'u') connect_pattern "$arguments" ;;
        'down'|'d') disconnect_auto ;;
        'reload'|'r') reload ;;
        'menu'|'m') connect_menu ;;
        *) printhelp ;;
    esac
}

if [ -n "$1" ]; then
    response="$1"
    handle_response
    exit
fi

while true ; do
    prompt="$(current | tr '[:upper:]' '[:lower:]')"
    [ -z "$prompt" ] && prompt="${col.emptyprompt}"
    printf "${col.prompt}$prompt${col.sep} ${col.sepchar} ${col.line}"

    read response

    echo
    handle_response
    echo
done
''
