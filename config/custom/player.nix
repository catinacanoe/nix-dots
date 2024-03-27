{ pkgs, ... }: pkgs.writeShellScriptBin "player" ''
TAGFILE="$XDG_MUSIC_DIR/meta/tags"
INDEXFILE="$XDG_MUSIC_DIR/meta/index"

letters="$(cat "$TAGFILE" | sed 's|[^ ]* ||' | tr ' ' '\n' | sort)"
songlist="$(cat "$INDEXFILE")"

while IFS= read -r letter; do
    tags=""
    taglist="$(cat "$INDEXFILE" | sed 's|^.* /// ||' | tr ' ' '\n' | grep "^$letter=" | sed "s|^$letter=||" | sort | uniq)"

    while true; do
        previewlist="$(echo "$songlist" | grep "$tags" | sed 's| /// .*$||')"
        previewcount="$(echo "$previewlist" | wc -l)"

        prompt="Tags for '$letter'"
        [ -n "$tags" ] && prompt+=": $(echo "$tags" | sed -e 's+\\|+, +g' -e "s|$letter=||g")"

        list="$(echo "$prompt" ; echo "$taglist")"
        selection="$(echo "$list" | fzf --preview "echo \"Count: $previewcount\" ; echo ; echo \"$previewlist\"")";

        if [ -n "$selection" ] && [ "$selection" != "$prompt" ]; then
            [ -z "$tags" ] && tags="$letter=$selection" || tags+="\|$letter=$selection"
        else break; fi
    done

    songlist="$(echo "$songlist" | grep "$tags")"
done <<< "$letters"

songlist="$(echo "$songlist" | sed 's| /// .*$||' | shuf)"

while IFS= read -r song; do
    mpc add "new/$song.mp3"
done <<< "$songlist"

echo "$songlist"
''
