{ pkgs, ... }: pkgs.writeShellScriptBin "plyr" ''
#########
# SETUP #
#########
cmd="$1"
arg="$2"
current=""
file="/tmp/plyr.dat"
[ -f "$file" ] || echo 'mpc' > "$file"

function processname() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

#######################
# FIND CURRENT PLAYER #
#######################
if mpc | sed -n 2p | grep -q '\[playing\]'; then
    current='mpc'
elif playerctl status | grep -q '^Playing$'; then
    current='playerctl'
fi

if [ -z "$current" ]; then
    current="$(cat "$file")"
fi

echo "$current" > "$file"

###################
# EXECUTE COMMAND #
###################
case "$cmd" in
    "set"): # just set the current player (alias for no arg)
        ;;
    "switch"): # switch to other player
        if [ "$current" == "mpc" ];
        then echo "playerctl" > "$file"
        else echo "mpc" > "$file"; fi
        ;;
    "toggle"): # play / pause
        if [ "$current" == "mpc" ];
        then mptoggle >> /dev/null
        else playerctl play-pause; fi
        ;;
    "play"):
        [ "$(plyr playing)" = "false" ] && plyr toggle ;;
    "pause"):
        [ "$(plyr playing)" = "true" ] && plyr toggle ;;
    "prev"):
        if [ "$current" == "mpc" ];
        then mpc prev
        else playerctl previous; fi
        ;;
    "next"):
        if [ "$current" == "mpc" ];
        then mpc next
        else playerctl next; fi
        ;;
    "seek"):
        if [ "$current" == "mpc" ];
        then mpc seek "$arg"
        else playerctl position "$arg"; fi
        ;;
    "playing"):
        if [ "$current" == "mpc" ]; then
            if mpc | sed -n 2p | grep -q '\[playing\]';
            then echo 'true'
            else echo 'false'; fi
        else
            if playerctl status | grep -q '^Playing$';
            then echo 'true'
            else echo 'false'; fi
        fi
        ;;
    "client"):
        echo "$current"
        ;;
    "current"):
        name=""

        if [ "$current" == "mpc" ]; then
            if [ "$(mpc status | wc -l)" != 1 ]; then
                name="$(mpc status | head -n 1 | sed 's|\.[^.]*$||')"
            fi
        else
            name="$(playerctl metadata title)"
            
            if [ -n "$name" ]; then
                # this code adds the artist name if player is spotify
                if echo "$(playerctl metadata xesam:url)" | grep -q 'spotify'; then
                    name="$(echo "$name" | sed -e 's| (.*)$||')" # remove ending parentheses (features and stuff)
                    name="$(playerctl metadata artist | sed 's|,.*||') - $name" # add in the first artist in the list
                fi

                name="$(echo "$name" | iconv -f utf8 -t ascii//TRANSLIT//IGNORE | LC_COLLATE=C sed \
                -e 's|\[.*\]\s*$||' \
                -e 's|feat\.|ft\.|' \
                -e 's+ | .* | NCS - Copyright Free Music\s*$++' \
                -e 's|\s*(.*lyric.*)\s*||i' \
                -e 's|\s*(.*video.*)\s*||i' \
                -e "s/[^ 0-9a-zA-Z':().,-]//g" \
                -e 's| \+| |g' \
                -e 's|^\s*||' \
                -e 's|\s*$||' # trailing whitespace
                )"
            fi
        fi
        processname "$name"
        ;;
    "progress"):
        if [ "$current" == "mpc" ]; then
            mpc status | sed -n 2p | sed -e 's|.*(||' -e 's|%)$||'
        else
            echo "100000000 * $(playerctl position) / $(playerctl metadata mpris:length)" | bc
        fi
        ;;
    "indicator"):
        if [ "$current" == "mpc" ]; then
            indicator=""

            mpc status | tail -n 1 | grep -q 'single: on' && indicator+="* "
            mpc status | tail -n 1 | grep -q 'random: off' && indicator+="~ "
            mpc status | tail -n 1 | grep -q 'repeat: off' && indicator+="- "

            echo "$indicator"
        else
            echo ""
        fi
        ;;
    "queue"):
        if [ "$current" == "mpc" ];
        then processname "$(mpc queue | sed 's|\.[^.]*$||')"
        else echo ""; fi
        ;;
    "color"):
        if [ "$current" == "mpc" ]; then
            color="$(grep "$(basename "$(plyr current)") /// " "$XDG_MUSIC_DIR/.index" | grep -o 't=[^ ]\+' | sed 's|^t=||')"
            [ -z "$color" ] && color="purple-orange-yellow"
            echo "$color"
        else
            echo "red-purple-orange"
        fi
        ;;
    *):
        echo "unrecognized command"
        ;;
esac
''
