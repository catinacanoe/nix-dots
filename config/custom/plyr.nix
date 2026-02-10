# script that unifies interaction with mpd and playerctl
# supports pause/play, skip, get current song etc
{ pkgs, ... }: pkgs.writeShellScriptBin "plyr" ''
#########
# SETUP #
#########
cmd="$1"
arg="$2"
current=""
file="/tmp/plyr.dat"
[ -f "$file" ] || echo 'mpc' > "$file"

########################
# FUNCTION DEFINITIONS #
########################
function lowercase() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

function rmspecialchars() {
    echo "$1" | iconv -f utf8 -t ascii//TRANSLIT//IGNORE | LC_COLLATE=C sed -e "s/[^ 0-9a-zA-Z':().,-]//g"
}

function transliterate() {
    echo "$1" | sed \
        -e 's|[Аа]|a|g' \
        -e 's|[Бб]|b|g' \
        -e 's|[Вв]|v|g' \
        -e 's|[Гг]|g|g' \
        -e 's|[Дд]|d|g' \
        -e 's|[Ее]|e|g' \
        -e 's|[Ёё]|yo|g' \
        -e 's|[Жж]|zh|g' \
        -e 's|[Зз]|z|g' \
        -e 's|[Ии]|i|g' \
        -e 's|[Йй]|i|g' \
        -e 's|[Кк]|k|g' \
        -e 's|[Лл]|l|g' \
        -e 's|[Мм]|m|g' \
        -e 's|[Нн]|n|g' \
        -e 's|[Оо]|o|g' \
        -e 's|[Пп]|p|g' \
        -e 's|[Рр]|r|g' \
        -e 's|[Сс]|s|g' \
        -e 's|[Тт]|t|g' \
        -e 's|[Уу]|u|g' \
        -e 's|[Фф]|f|g' \
        -e 's|[Хх]|x|g' \
        -e 's|[Цц]|c|g' \
        -e 's|[Чч]|ch|g' \
        -e 's|[Шш]|sh|g' \
        -e 's|[Щщ]|sh|g' \
        -e 's|[Ъъ]||g' \
        -e 's|[Ыы]|i|g' \
        -e 's|[Ьь]||g' \
        -e 's|[Ээ]|e|g' \
        -e 's|[Юю]|yu|g' \
        -e 's|[Яя]|ya|g'
}

#######################
# FIND CURRENT PLAYER #
#######################
if mpc | sed -n 2p | grep -q '\[playing\]'; then
    current='mpc'
elif spotifycli --playbackstatus | grep -q '^▶$'; then
    current='spotify'
elif mpvc status | sed -n 2p | grep -q '^\[play\] '; then
    current='mpv'
elif playerctl status | grep -q '^Playing$'; then
    current='playerctl'
fi

if [ -z "$current" ]; then
    current="$(cat "$file")"
fi

# if our current is mpv but the mpv has now been closed, we will not be able to return a lot of data correctly (maybe set back to another player)
if [ "$current" == "mpv" ]; then
    mpvc status | head -n 1 | grep -q '^.mpvc-wrapped: Error: No files added' && current='spotify'
fi

echo "$current" > "$file"

###################
# EXECUTE COMMAND #
###################
case "$cmd" in
    "set"): # just set the current player (alias for no arg)
        ;;
    "toggle"): # play / pause
        if [ "$current" == "mpc" ]; then mptoggle >> /dev/null
        elif [ "$current" == "spotify" ]; then spotifycli --playpause >> /dev/null
        elif [ "$current" == "mpv" ]; then mpvc toggle >> /dev/null
        else playerctl play-pause; fi
        ;;
    "play"):
        [ "$(plyr playing)" = "false" ] && plyr toggle ;;
    "pause"):
        [ "$(plyr playing)" = "true" ] && plyr toggle ;;
    "prev"):
        if [ "$current" == "mpc" ]; then mpc prev
        elif [ "$current" == "spotify" ]; then spotifycli --prev
        elif [ "$current" == "mpv" ]; then mpvc prev
        else playerctl previous; fi
        ;;
    "next"):
        if [ "$current" == "mpc" ]; then mpc next
        elif [ "$current" == "spotify" ]; then spotifycli --next
        elif [ "$current" == "mpv" ]; then mpvc next
        else playerctl next; fi
        ;;
    "seek"):
        if [ "$current" == "mpc" ]; then mpc seek "$arg"
        elif [ "$current" == "spotify" ]; then true
        elif [ "$current" == "mpv" ]; then mpvc seek "$arg"
        else playerctl position "$arg"; fi
        ;;
    "playing"):
        if [ "$current" == "mpc" ]; then
            if mpc | sed -n 2p | grep -q '\[playing\]';
            then echo 'true'
            else echo 'false'; fi
        elif [ "$current" == "spotify" ]; then
            if spotifycli --playbackstatus | grep -q '^▶$';
            then echo 'true'
            else echo 'false'; fi
        elif [ "$current" == "mpv" ]; then
            if mpvc status | sed -n 2p | grep -q '^\[play\] ';
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
            name=""
            if [ "$current" == "spotify" ]; then
                name="$(spotifycli --song)"
            elif [ "$current" == "mpv" ]; then
                name="$(mpvc status | head -n 1 | sed 's|^NA - ||')"
            elif [ "$current" == "playerctl" ]; then
                name="$(playerctl metadata title)"
            else
                name="na"
            fi
            
            if [ -n "$name" ]; then
                # transliterate russian
                name="$(transliterate "$name")"
                name="$(rmspecialchars "$name")"

                # removes trailing whitespace
                # removes leading whitespace
                # any trailing [] square brackets
                # removes any trailing () parens
                # changes feat. to ft.
                # compresses all whitespace to single spaces
                name="$(echo "$name" | sed \
                -e 's|\s*$||' \
                -e 's|^\s*||' \
                -e 's|\[.*\]\s*$||' \
                -e 's|\s*(.*)$||' \
                -e 's|feat\.|ft\.|' \
                -e 's|\s\+| |g'
                )"
            fi
        fi
        lowercase "$name"
        ;;
    "progress"):
        if [ "$current" == "mpc" ]; then
            mpc status | sed -n 2p | sed -e 's|.*(||' -e 's|%)$||'
        elif [ "$current" == "spotify" ]; then
            spotifycli --position | sed -e 's|/|)/(|' -e 's|:|*60+|g' -e 's|^|100*|' | bc
        elif [ "$current" == "mpv" ]; then
            mpvc status | sed -n 2p | grep -o '([0-9]\+%)$' | grep -o '[0-9]\+'
        elif [ "$current" == "playerctl" ]; then
            echo "100000000 * $(playerctl position) / $(playerctl metadata mpris:length)" | bc
        else true; fi
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
        then lowercase "$(mpc queue | sed 's|\.[^.]*$||')"
        else echo ""; fi
        # `mpvc playlist` can be used but I don't have a strong enough need to fuck around with that
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
        echo "manual for 'plyr'"
        echo ""
        echo "set"
        echo "    just checks what player is currently running and saves it"
        echo ""
        echo "play"
        echo "    starts playback from the active player (does nothing if already playing)"
        echo ""
        echo "pause"
        echo "    same as 'play' but pauses playback"
        echo ""
        echo "playing"
        echo "    prints 'true' if active player is playing media, 'false' otherwise"
        echo ""
        echo "toggle"
        echo "    toggles playback on and off ('pause' if 'playing' is true, 'play' otherwise)"
        echo ""
        echo "prev"
        echo "    goes to the previous song"
        echo ""
        echo "next"
        echo "    plays the next song"
        echo ""
        echo "seek"
        echo "    seeks back and forth thru the currently playing media (expects argument like '+5' which would seek 5 sec forward)"
        echo ""
        echo "client"
        echo "    prints out the current player client ('mpc' or 'playerctl')"
        echo ""
        echo "current"
        echo "    prints the currently playing piece of media"
        echo ""
        echo "progress"
        echo "    prints the progress through current song as a percentage (0-100)"
        echo ""
        echo "indicator"
        echo "    only relevant for mpc player. prints * if single song loop is on, ~ if randomization, - if queue loop is on"
        echo ""
        echo "queue"
        echo "    prints the next queued song (only works for mpc player)"
        ;;
esac
''
