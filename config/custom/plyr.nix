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
                    name="$(echo "$name" | sed -e 's| (.*)$||' -e 's|\s*-.*$||')" # remove ending parentheses (features and stuff), and also anything after a dash
                fi

                # transliterate russian
                name="$(echo "$name" | sed \
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
                )"

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
