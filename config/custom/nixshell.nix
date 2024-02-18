{ pkgs, ... }:
let
    home = "/home/canoe";
    repos = "${home}/repos";
    private = "${repos}/nix-dots/private";
    confighome = "${home}/.config/";
in
pkgs.writeShellScriptBin "nixshell" ''
function printhelp() {
    echo "'nixshell' interactive shell to run nix switch and hm quickly (please run as root)"
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
    echo "activating home manager"
    home-manager switch --show-trace --flake path:${repos}/nix-dots/ || notify-send "nixshell" "ERROR in home manager activation"
}

function nixos() {
    echo "rebuilding the nixos system"
    sudo nixos-rebuild switch --show-trace --flake path:${repos}/nix-dots/ || notify-send "nixshell" "ERROR in nixos rebuild"
}

function activate_ff() {
    echo "activating firefox"
    [ -n "$(pgrep firefox)" ] && echo "killing all firefox windows" && killall .firefox-wrapped

    echo "clearing firefox build"
    out="$(rm -rfv "${private}/firefox-build/")"
    echo "$out" | head
    echo

    echo "pulling runtime config from ~/.mozilla"
    out="$(cp -rv ~/.mozilla/ "${private}/firefox-build/")"
    echo "$out" | head
    out="$(rm -rf "${private}/firefox-build/firefox/scratch")"
    out="$(rm -rf "${private}/firefox-build/firefox/gpt")"
    out="$(cp -r "${private}/firefox-build/firefox/main" "${private}/firefox-build/firefox/scratch")"
    out="$(cp -r "${private}/firefox-build/firefox/main" "${private}/firefox-build/firefox/gpt")"
    echo

    echo "overlaying generated files"
    out="$(cp -rv "${private}/firefox-gen"/* "${private}/firefox-build/firefox/main/")"
    out="$(cp -rv "${private}/firefox-gen"/* "${private}/firefox-build/firefox/scratch/")"
    out="$(cp -rv "${private}/firefox-gen-nodecor"/* "${private}/firefox-build/firefox/gpt/")"
    echo "$out" | head
    echo

    echo "removing files from ~/.mozilla"
    out="$(rm -rf ~/.mozilla/)"
    echo "$out" | head
    echo

    echo "copying files from store to mozilla"
    out="$(cp -r "${private}/firefox-build" ~/.mozilla/)"
    echo "$out" | head
}

function activate_xx() {
    echo "activating xioxide"
    source ${repos}/xioxide/main.sh reload
}

function activate_dc() {
    echo "activating vencord"
    cat ${confighome}/Vencord-gen/settings/settings.json > ${confighome}/Vencord/settings/settings.json
    cat ${confighome}/Vencord-gen/themes/Translucence.theme.css > ${confighome}/Vencord/themes/Translucence.theme.css
}

function handle_response() {
    if [ -z "$response" ] || [ "$response" == "help" ]; then
        echo
        printhelp
        return
    fi

    if [ "$response" == "quit" ]; then
        exit
    fi

    for (( i=0; i<${"\${#response}"}; i++ )); do
        char="${"\${response:$i:1}"}"

        if [ "$char" == "n" ]; then
            echo
            nixos
            notify-send "nixshell" "nixos rebuild complete"
        elif [ "$char" == "h" ]; then
            echo
            homeman
            notify-send "nixshell" "home manager complete"
        elif [ "$char" == "f" ]; then
            echo
            activate_ff
            notify-send "nixshell" "firefox activation complete"
        elif [ "$char" == "d" ]; then
            echo
            activate_dc
            notify-send "nixshell" "discord activation complete"
        elif [ "$char" == "x" ]; then
            echo
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
    printf "\033[0;36mnix\033[0;34m > \033[0m"
    read response
    handle_response
    echo
done
''
