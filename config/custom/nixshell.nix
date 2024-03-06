{ pkgs, ... }:
let
    home = "/home/canoe";
    repos = "${home}/repos";
    private = "${repos}/nix-dots/private";
    confighome = "${home}/.config/";
in
pkgs.writeShellScriptBin "nixshell" ''
function printhelp() {
    echo "'nixshell' interactive shell to run nix switch and hm quickly"
    echo
    echo "help"
    echo "    prints out this help menu with a list of commands"
    echo
    echo "quit"
    echo "    quit this interactive shell"
    echo
    echo "h"
    echo "    runs home manager"
    echo
    echo "n"
    echo "    runs nixos-rebuild switch"
    echo
    echo "f"
    echo "    runs the firefox activation script"
    echo
    echo "x"
    echo "    runs the xioxide activation script"
    echo
    echo "d"
    echo "    runs the discord activation script"
}

function homeman() {
    echo
    echo "activating home manager"
    home-manager switch --show-trace --flake path:${repos}/nix-dots/ || notify-send "nixshell" "ERROR in home manager activation"
}

function nixos() {
    echo
    echo "rebuilding the nixos system"
    sudo nixos-rebuild switch --show-trace --flake path:${repos}/nix-dots/#default || notify-send "nixshell" "ERROR in nixos rebuild"
}

function hm_news() {
    echo
    home-manager news --flake path:${repos}/nix-dots/
}

function activate_ff() {
    echo
    echo "running firefox preactivation"
    killall .firefox-wrapped

    rm -rvf ~/.mozilla/firefox/gpt/
    rm -rvf ~/.mozilla/firefox/scratch/

    cp -r ~/.mozilla/firefox/main/ ~/.mozilla/firefox/gpt/
    cp -r ~/.mozilla/firefox/main/ ~/.mozilla/firefox/scratch/
}

function activate_xx() {
    echo
    echo "activating xioxide"
    source ${repos}/xioxide/main.sh reload
}

function handle_response() {
    if [ -z "$response" ] || [ "$response" == "help" ]; then
        echo
        printhelp
        return
    elif [ "$response" == "quit" ]; then
        exit
    elif [ "$response" == "news" ]; then
        hm_news
        return
    fi

    for (( i=0; i<${"\${#response}"}; i++ )); do
        char="${"\${response:$i:1}"}"

        if [ "$char" == "n" ]; then
            nixos
            notify-send "nixshell" "nixos rebuild complete"
        elif [ "$char" == "h" ]; then
            homeman
            notify-send "nixshell" "home manager complete"
        elif [ "$char" == "f" ]; then
            activate_ff
            notify-send "nixshell" "firefox preactivation complete"
        elif [ "$char" == "x" ]; then
            activate_xx
            notify-send "nixshell" "xioxide activation complete"
        else
            echo "character $char not recognized"
        fi
    done
}

if [ -n "$1" ]; then
    response="$1"
    handle_response
    exit
fi

while true ; do
    printf "\033[0;35mnix\033[0;31m > \033[0m"
    read response
    handle_response
    echo
done
''
