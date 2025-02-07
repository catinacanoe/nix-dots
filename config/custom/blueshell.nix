{ pkgs, ... }: let col = import ./.shellcol.nix; in pkgs.writeShellScriptBin "blueshell" ''

set -a # export all functions (so debug shell inherits them) (idt this works)

function printhelp() {
    echo "'blueshell' interactive shell wrapper for bluetoothctl (for interacting with bluetooth devices)"
    echo
    echo "help | h"
    echo "    prints out this help menu with a list of commands"
    echo
    echo "active | a"
    echo "    shows the currently active device"
    echo
    echo "connect | up | c | u"
    echo "    will connect to device indicated in argument (either address or name)"
    echo "    if no argument is passed, automatically tries to connect to a device until it succeeds (in order defined in \$BLUESHELL_AUTOCONNECT_PRIORITY)"
    echo
    echo "disconnect | down | d"
    echo "    disconnects from the vpn server"
    echo
    echo "reload | restart | r"
    echo "    disconnects and reconnects to the currently active device"
    echo
    echo "list | l"
    echo "    lists all bluetooth devices"
    echo
    echo "drop"
    echo "    drop you into a bluetoothctl shell"
    echo
    echo "quit | q"
    echo "    quit this interactive shell"
}

# in general this file uses adresses and only converts to device names for display purposes

function list() {
    local flags="$(echo Paired;echo Bonded;echo Trusted;echo Connected)"

    local flag=""
    [ -n "$1" ] && flag="$(echo "$flags" | grep -i "$1" | head -n 1)"

    bluetoothctl devices $flag | sed 's|^Device ||'
}

function list_name() {
    list $1 | sed 's|^[^ ]* ||'
}

function list_address() {
    list $1 | sed 's| .*$||'
}

function current() {
    list_name connected | head -n 1
}

function to_name() { # expects an adress in $1
    list | grep "^$1 " | sed "s|^$1 ||"
}

function to_address() { # expects a name in $1
    list | grep " $1$" | sed "s| $1$||"
}

function connect_to() { # expects an address
    [ -z "$1" ] && echo "no address passed in" && return
    echo "connecting to $(to_name "$1") ..."
    bluetoothctl connect $1 || return 1
}

function connect_pattern() {
    name="$(list_name | grep -i "^$1" | head -n 1)"
    [ -z "$name" ] && echo "failed to find a device matching search pattern '^$1'" && return

    connect_to "$(to_address "$name")"
}

function connect_auto() {
    if [ -n "$1" ]; then
        connect_pattern "$1"
        return
    fi

    [ -z "$BLUESHELL_AUTOCONNECT_PRIORITY" ] && BLUESHELL_AUTOCONNECT_PRIORITY="40:DA:5C:E4:43:57"

    while IFS= read -r address; do
        connect_to "$address" && return
    done <<< "$(echo "$BLUESHELL_AUTOCONNECT_PRIORITY" | sed 's| |\n|g')"

    echo "failed to autoconnect to any of these devices: $BLUESHELL_AUTOCONNECT_PRIORITY"
}

function connect_menu() {
    selection="$(list | fzf)"
    [ -z "$selection" ] && echo "no selection" && return

    address="$(echo "$selection" | sed 's| .*$||')"

    connect_to "$address"
}

function disconnect_from() { # expects an address
    [ -z "$1" ] && echo "no address passed in" && return

    # TODO this assumes that all bt devices are audio devices, fix eventually
    plyr pause

    echo "disconnecting from $(to_name "$1") ..."
    bluetoothctl disconnect $1
}

function disconnect_auto() {
    selection="$(current)"
    [ -z "$selection" ] && echo "no bluetooth device connected" && return
    disconnect_from "$(to_address "$selection")"
}

function reload() {
    name="$(current)"
    address="$(to_address "$name")"
    playing="$(plyr playing)"

    echo "reloading $name ..."
    disconnect_from "$address"
    echo "sleeping for 1s" && sleep 1
    connect_to "$address"
    
    [ "$playing" = "true" ] && plyr play
}

function handle_response() {
    action="$(echo "$response" | awk '{ print $1 }')"
    arguments="$(echo "$response" | sed -e 's|^[^ ]*||' -e 's|^ *||')"

    case "$action" in
        'quit'|'q'|':q'|'z') exit ;;
        'help'|'h') printhelp ;;
        'active'|'a') current ;;
        'list'|'l') list ;;
        'up'|'u') connect_auto "$arguments" ;;
        'down'|'d') disconnect_auto ;;
        'drop') bluetoothctl && echo ;;
        'sh') /usr/bin/env zsh ;;
        'reload'|'r') reload ;;
        'menu'|'m') connect_menu ;;
        'rename') bluetoothctl set-alias "$arguments" ;;
        'address') to_address "$arguments" ;;
        'name') to_name "$arguments" ;;
        *) true ;;
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
