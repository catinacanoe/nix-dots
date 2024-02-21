{ pkgs, ... }: pkgs.writeShellScriptBin "nmshell" ''
function printhelp() {
    echo "'nmshell' interactive shell to interface with nmcli network manager"
    echo
    echo "help"
    echo "    prints out this help menu with a list of commands"
    echo
    echo "quit|q|:q"
    echo "    quit this interactive shell"
    echo
    echo "u"
    echo "    the first argument is a search string, used to grep through active networks, connects to the first match"
    echo
    echo "c"
    echo "    allow the user to select a network to connect to from a list of networks"
}

function nmcli_updater() {

}

function available_networks() {
    nmcli -t device wifi list --rescan no | grep -v '::' | awk -F ':' '{ print "("$12") "$8 }'
}

function handle_response() {
    action="$(echo "$response" | awk '{ print $1 }')"
    action="$(echo "$response" | awk '{ for (i=2;i<NF;i++) printf $i" "; print $NF }')"

    if [ -z "$action" ] || [ "$action" == "help" ]; then
        echo
        printhelp
        return
    fi

    case "$response" in
        quit|q|:q) exit ;;
    esac
}

if [ -n "$1" ]; then
    response="$1"
    handle_response
    exit
fi

while true ; do
    printf "\033[0;35mnet\033[0;31m > \033[0m"
    read response
    handle_response
    echo
done
''
