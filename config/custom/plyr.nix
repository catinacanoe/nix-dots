{ pkgs, ... }: pkgs.writeShellScriptBin "plyr" ''
#########
# SETUP #
#########
cmd="$1"
arg="$2"
current=""
file="/tmp/plyr.dat"
[ -f "$file" ] || echo 'mpc' > "$file"

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
                if echo "$name" | grep -q " - "; then true
                elif echo "$name" | grep -q " — "; then true
                else
                    name="$(playerctl metadata artist | sed 's| - Topic$||') - $name"
                fi

                name="$(echo "$name" | sed \
                -e 's|\[.*\]\s*$||' \
                -e 's+ | .* | NCS - Copyright Free Music\s*$++' \
                -e 's|\s*(.*lyric.*)\s*||i' \
                -e 's|\s*(.*video.*)\s*||i' \
                -e 's|\s*$||'
                )"
            fi
        fi
        echo "$name"
        ;;
    "progress"):
        if [ "$current" == "mpc" ];
        then mpc status | sed -n 2p | sed -e 's|.*(||' -e 's|%)$||'
        else echo "0"; fi
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
        then mpc queue | sed 's|\.[^.]*$||'
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
