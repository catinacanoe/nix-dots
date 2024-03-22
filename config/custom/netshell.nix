{ pkgs, ... }: pkgs.writeShellScriptBin "netshell" ''
function auto_vpn() { # convenient place to put this 
    while true; do
        if [ -n "$(cat /tmp/net-check)" ]; then
            local net="$(nmcli -t connection show --active | grep -v 'loopback' | head -n 1 | awk -F : '{ print $1 }' | tr '[:upper:]' '[:lower:]')"

            if [ "$net" == "fuhsd" ]; then
                nmcli connection down "$net" &> /dev/null
                nmcli connection up "$net" &> /dev/null
                vpnshell reload &> /dev/null
            else
                nmcli connection down "$net" &> /dev/null
                nmcli connection up "$net" &> /dev/null
                vpnshell disconnect &> /dev/null
            fi
        fi
    sleep 1; done
};

function printhelp() {
    echo "'nmshell' interactive shell to interface with nmcli network manager"
    echo
    echo "help|h"
    echo "    prints out this help menu with a list of commands"
    echo
    echo "quit|q|:q"
    echo "    quit this interactive shell"
    echo
    echo "active|a"
    echo "    just prints the current active connection"
    echo
    echo "list|l"
    echo "    lists all available connections"
    echo
    echo "up|u"
    echo "    the first argument is a search string, used to grep through active networks, connects to the first match"
    echo
    echo "down|d"
    echo "    disconnect from the currently active connection"
    echo
    echo "reload|r"
    echo "    reload the current connection"
    echo
    echo "menu|m"
    echo "    allow the user to select a network to connect to from a list of networks"
    echo
    echo "ping|p"
    echo "    pings google.com to check connectivity"
    echo
    echo "test|t"
    echo "    runs the 'speedtest' utility"
    echo
    echo "credentials|c"
    echo "    print out the credentials to the current network"
    echo
    echo "vpn|v"
    echo "    passes its arguments through to the vpnshell command"
}

function vpn-network() { echo "$@" | grep -q '^fuhsd$'; }

function current() {
    nmcli -t connection show --active | grep -v 'loopback' | head -n 1 | awk -F : '{ print $1 }'
}

function list() {
    nmcli -t device wifi list --rescan yes | grep -v '::' | awk -F ':' '{ print $8 }' | sort | uniq
}

function network_menu() {
    connection="$(list | fzf)"
    [ -z "$connection" ] && return

    echo "connecting to $connection ..."
    nmcli device wifi connect "$connection"

    vpn-network "$connection" && vpnshell connect
}

function search_connect() {
    connection="$(list | grep -i "^$1" | head -n 1)"
    [ -z "$connection" ] && echo "failed to find connection matching search pattern '^$1'" && return

    echo "connecting to $connection ..."
    nmcli device wifi connect "$connection"

    vpn-network "$connection" && vpnshell connect
}

function disconnect() {
    connection="$(current)"

    echo "disconnecting from $connection ..."
    nmcli connection down "$connection"
    
    vpn-network "$connection" && vpnshell disconnect
}

function reload() {
    connection="$(current)"

    echo "reloading $connection ..."
    nmcli connection down "$connection"
    nmcli connection up "$connection"
    
    vpn-network "$connection" && vpnshell reload
}

function credentials() {
    echo -n "show credentials to current network? (y/n)" && read -n 1 key
    [ "$key" == "y" ] && nmcli device wifi show-password
}

function handle_response() {
    action="$(echo "$response" | awk '{ print $1 }')"
    arguments="$(echo "$response" | awk '{ for (i=2;i<NF;i++) printf $i" "; print $NF }')"

    case "$action" in
        'quit'|'q'|':q') exit ;;
        'help'|'h') printhelp ;;
        'active'|'a') current ;;
        'list'|'l') list ;;
        'up'|'u') search_connect "$arguments" ;;
        'down'|'d') disconnect ;;
        'reload'|'r') reload ;;
        'menu'|'m') network_menu ;;
        'ping'|'p') ping google.com ;;
        'test'|'t') speedtest ;;
        'credentials'|'c') credentials ;;
        'vpn'|'v') vpnshell "$arguments" ;;
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
    [ -z "$prompt" ] && prompt="---"
    printf "\033[0;35m$prompt\033[0;31m > \033[0m"

    read response

    echo
    handle_response
    echo
done
''
