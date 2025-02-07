{ pkgs, ... }:
let
    home = "/home/canoe";
    repos = "${home}/repos";
    col = import ./.shellcol.nix;
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
    echo "ew"
    echo "    prints news"
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
    echo "close all firefox instances, hit enter when done"
    read
    killall .firefox-wrapped

    mainffdir="$HOME/.mozilla/firefox/main"
    profiles="$(echo gpt && echo scratch && echo calendar)" # add profile here and in ~/.moz/ff
    sleeptime="1.2"

    while IFS= read -r line; do
        tmpdir="$(mktemp -d "firefox-activation-$line.XXXXXXX" --tmpdir)"
        ffdir="$HOME/.mozilla/firefox/$line"
        sessfiles="$(find "$ffdir" -maxdepth 1 | grep session | sed 's|.*/||')"

    
        echo && echo "rebuilding $line profile"

        echo && echo "saving $line session files" && sleep "$sleeptime"
        while IFS= read -r file; do
            cp -rv "$ffdir/$file" "$tmpdir/$file"
        done <<< "$sessfiles"

        echo && echo "copying main profile over to $line" && sleep "$sleeptime"
        rm -rvf "$ffdir"
        cp -rv "$mainffdir" "$ffdir"

        echo && echo "restoring $line session files" && sleep "$sleeptime"
        while IFS= read -r file; do
            rm -rvf "$ffdir/$file"
            cp -rv "$tmpdir/$file" "$ffdir/$file"
        done <<< "$sessfiles"
    done <<< "$profiles"
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
    elif [ "$response" == "z" ]; then
        exit
    elif [ "$response" == "s" ]; then
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
            notify-send "nixshell" "firefox preactivation running..."
            activate_ff
            notify-send "nixshell" "firefox preactivation complete"
        elif [ "$char" == "x" ]; then
            notify-send "nixshell" "xioxide activation running..."
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
    printf "${col.prompt}nix${col.sep} ${col.sepchar} ${col.line}"
    read response
    handle_response
    echo
done
''
