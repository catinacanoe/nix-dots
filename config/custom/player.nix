{ pkgs, ... }: pkgs.writeShellScriptBin "player" ''
TAGFILE="$XDG_MUSIC_DIR/.tags"
INDEXFILE="$XDG_MUSIC_DIR/.index"

letters="$(cat "$TAGFILE" | sed 's|[^ ]* ||' | tr ' ' '\n' | sort)"
songlist="$(cat "$INDEXFILE")"
tags="$(echo "$letters" | sed 's|^.|&:|')"

function filterlist() {
    local grepstrings

    while IFS= read -r line; do
        local letter="$(echo "$line" | grep -o '^.')"
        grepstrings="$(
            echo "$grepstrings"
            echo "$line" | sed -e 's|^..||' -e "s_ _\\\\|$letter=_g" -e 's|^..||'
        )"
    done <<< "$tags"

    local out="$songlist"
    while IFS= read -r line; do
        out="$(echo "$out" | grep "$line")"
    done <<< "$grepstrings"

    echo "$out" | sed 's| /// .*$||'
}

function preview() {
    echo "$tags" | grep ' .' && echo
    filterlist
}

function tagchoose() {
    while true; do
        letter="$(echo "$letters" | fzf --preview "echo \"$(preview)\"")"
        [ -z "$letter" ] && break

        prompt="Choose '$letter' tags"
        tagoptions="$(echo "$prompt" ;echo; cat "$INDEXFILE" | sed 's|^.* /// ||' | tr ' ' '\n' | grep "^$letter=" | sed "s|^$letter=||" | sort | uniq)"

        while true; do
            chosentag="$(echo "$tagoptions" | fzf --preview "echo \"$(preview)\"")"

            if [ -n "$chosentag" ] && [ "$chosentag" != "$prompt" ]; then
                tags="$(echo "$tags" | sed "s|$letter:.*|& $chosentag|")"
            else break; fi
        done
    done

    while IFS= read -r song; do
        mpc add "$song.mp3"
    done <<< "$(filterlist)"
}

choices="$(echo 'clear tag choose' | tr ' ' '\n')"
while true; do
    mpc update &> /dev/null
    choice="$(echo "$choices" | fzf)"

    case "$choice" in
        clear) mpc clear ;;
        tag) tagchoose;;
        choose)
            song="$(echo "$songlist" | sed 's| /// .*||' | fzf).mp3"
            mpc insert "$song"
        ;;
        *) break ;;
    esac
done
''
