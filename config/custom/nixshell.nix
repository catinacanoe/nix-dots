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
    read # wait until enter
    killall .firefox-wrapped

    mainffdir="$HOME/.mozilla/firefox/main"
    profiles="$(echo gpt && echo scratch && echo calendar)" # add profile here and in ~/.moz/ff
    sleeptime="1.2"
    nixprefsdir="$XDG_REPOSITORY_DIR/nix-dots/home/firefox/etc/extensions-prefs"

    echo && echo "do you want to: (enter 1 2 or 3)"
    echo "1. save preferences and extensions"
    echo "2. load them from the nix-dots folder"
    echo "3. continue without doing either"
    echo
    echo -n "-> "
    read response
    
    preffiles="$(find "$mainffdir" -maxdepth 1 | grep -e extension -e addon -e prefs -e settings | sed 's|.*/||')"

    case "$response" in
        "1")
            echo && echo "clearing nixdots ff prefs dir: $nixprefsdir"
            rm -rfv "$nixprefsdir"
            mkdir "$nixprefsdir"

            echo && echo "saving preferences from main profile to nixdots@$nixprefsdir"
            echo "files/folders to be saved:"
            echo "$preffiles" && sleep "$sleeptime"
            while IFS= read -r file; do
                cp -rv "$mainffdir/$file" "$nixprefsdir/$file"
            done <<< "$preffiles"
            ;;
        "2")
            echo && echo "loading preferences from nixdots to main profile"
            echo "files/folders to be saved:"
            echo "$preffiles" && sleep "$sleeptime"
            while IFS= read -r file; do
                rm -rvf "$mainffdir/$file"
                cp -rv "$nixprefsdir/$file" "$mainffdir/$file"
            done <<< "$preffiles"
            ;;
        *)
            echo "got response: '$response'"
            echo "doing neither and continuing" && sleep $sleeptime
            ;;
    esac


    echo && echo "duplicating all settings from main profile to all others:"
    echo "$profiles"
    echo "(while preserving session data)"

    while IFS= read -r line; do
        tmpdir="$(mktemp -d "firefox-activation-$line.XXXXXXX" --tmpdir)"
        ffdir="$HOME/.mozilla/firefox/$line"
        sessfiles="$(find "$ffdir" -maxdepth 1 | grep session | sed 's|.*/||')"

    
        echo && echo "rebuilding $line"

        echo && echo "saving $line session" && sleep "$sleeptime"
        while IFS= read -r file; do
            cp -rv "$ffdir/$file" "$tmpdir/$file"
        done <<< "$sessfiles"

        echo && echo "copying main -> $line" && sleep "$sleeptime"
        rm -rvf "$ffdir"
        cp -rv "$mainffdir" "$ffdir"

        echo && echo "restoring $line session" && sleep "$sleeptime"
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
