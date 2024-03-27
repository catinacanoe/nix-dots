{ pkgs, ... }: pkgs.writeShellScriptBin "mustagger" ''
TARGETPATH="$XDG_MUSIC_DIR"
INDEXFILE="$XDG_MUSIC_DIR/.index"
TAGFILE="$XDG_MUSIC_DIR/.tags"

function get_file() {
    local input="$1"
    [ -z "$input" ] && echo "ERROR: get_file: please pass input" && return
    local target

    if echo "$input" | grep -q 'http'; then
        local name="$(yt-dlp --skip-download --get-title --no-warnings "$input")"
        target="$TARGETPATH/$name.mp3"
        yt-dlp -o "$target" -x --audio-format mp3 --audio-quality 0 "$input" &> /dev/null
        notify-send "music download complete"

    elif [ -f "$input" ]; then
        target="$TARGETPATH/$(basename "$input")"
        mv "$input" "$target" &> /dev/null

    else echo "ERROR: get_file: unrecognized input: $input" && return; fi

    echo "$target"
}

function start_playback() {
    local name="$1"

    mpc update
    mpc insert "$name"
    mpc single on
    mpc play
    mpc next
}

function rename_file() {
    local original="$(basename "$1" | sed -s 's|\.[^.]*$||')"

    local file="/tmp/$original.tmp"
    echo "Rename this file (output will be read from bottom line):" > "$file"
    echo "$original" >> "$file"

    echo "$file"
}

function mk_tag() {
    local letter="$1"
    local preview="$2"

    if [ "$letter" == "e" ]; then
        preview="$(
            echo "$preview"
            echo "
0 - binaural beats; shit u could fall asleep to
1 - low amount of percussion, like some celeste songs
2 - stuff like tanger's bossanova or lofi; has percussion but still chill
3 - acoustic songs
4 - chillish edm with some drops (instinct type beat) (or chill rock)
5 - edm with louder drops, stuff like future bass
6 - things like dnb: hits hard but still ok
7 - melodic dubstep, other lower level forms of dubstep
8 - dubsteppppppp or heavy metal ig but i don't have any lmao
9 - TEAROUT / DEATHSTEP
            "
        )"
    fi

    local tag
    local response="$(cat "$INDEXFILE" | sed 's|^.* /// ||' | tr ' ' '\n' | grep "^$letter=" | sed "s|^$letter=||" | sort | uniq | fzf --print-query --preview "echo \"$preview\"")"
    local query="$(echo "$response" | head -n 1)"
    local selected="$(echo "$response" | sed -n 2p)"

    if echo "$query" | grep -q "\*$"; then
        [ "$query" == "*" ] && return
        echo "$query" | sed 's/\*$//'
    elif [ -z "$selected" ]; then
        echo "$query"
    else
        echo "$selected"
    fi
}

function mk_taglist() {
    local single_letters="$(cat "$TAGFILE" | grep '^single' | sed 's|^single ||' | tr ' ' '\n')"
    local multi_letters="$(cat "$TAGFILE" | grep '^multi' | sed 's|^multi ||' | tr ' ' '\n')"
    local done_letters=""
    local taglist

    while true; do
        # select a letter
        local letterlist
        if [ -z "$done_letters" ]; then
            letterlist="$(echo -e "$single_letters\n$multi_letters")"
        else
            letterlist="$(echo -e "$single_letters\n$multi_letters" | grep -v "$(echo "$done_letters" | tr '\n' ' ' | sed 's+ \(.\)+\\\|\1+g' | tr ' ' '\n')")"
        fi

        local letter="$(echo "$letterlist" | sort | fzf --preview "echo \"$taglist\"" | sed 's|^\(.\) *$|\1|')"
        [ -z "$letter" ] && break

        if echo "$single_letters" | grep -q "$letter"; then
            local tag="$(mk_tag "$letter" "$taglist")"
            [ -z "$tag" ] && continue
            taglist="$(
                [ -n "$taglist" ] && echo "$taglist"
                echo "$letter=$tag"
            )"

            done_letters="$(
                [ -n "$done_letters" ] && echo "$done_letters"
                echo "$letter"
            )"; done_letters="$(echo "$done_letters" | sort | uniq)"
        elif echo "$multi_letters" | grep -q "$letter"; then
            while true; do
                local tag="$(mk_tag "$letter" "$taglist")"
                [ -z "$tag" ] && break
                taglist="$(
                    [ -n "$taglist" ] && echo "$taglist"
                    echo "$letter=$tag"
                )"
            done
        fi
    done

    local doublecheck="$(mktemp)"
    echo "$taglist" | sort | tr '\n' ' ' > "$doublecheck"
    echo "$doublecheck"
}

function handle_request() {
    local input="$1" # the link or path to the file we are working with

    local filename # the path to the original file

    # setup the file
    filename="$(get_file "$input")"
    if echo "$filename" | grep -q "^ERROR: "; then
        echo "$filename"
        return
    elif ! echo "$filename" | grep -q "\.mp3$"; then
        echo "ERROR: handle_request: file not in mp3 format"
        return
    fi

    # rename file
    local renamefile="$(rename_file "$filename")" # the result of the renaming
    $EDITOR "$renamefile"
    local targetstem="$(tail -n 1 "$renamefile")"
    local targetname="$TARGETPATH/$targetstem.mp3" # the new full path
    if [ -z "$targetstem" ]; then
        echo "ERROR: handle_request: renamed filename is empty"
        return
    fi
    mv "$filename" "$targetname"

    start_playback "$targetstem.mp3"

    # get all the tags
    local taglistfile="$(mk_taglist)"
    $EDITOR "$taglistfile"
    local taglist="$(head -n 1 "$taglistfile" | sed -e 's|\s*$||' -e 's|^\s*||')"
    if [ -z "$taglist" ]; then
        rm "$targetname"
        mpc del 0
        return
    fi

    # colortagging
    TEST_FILE="/tmp/eww-test-color"
    nvim "$TEST_FILE"
    taglist+=" t=$(cat "$TEST_FILE")"

    echo "$targetstem /// $taglist" >> "$INDEXFILE"
    echo "" > "$TEST_FILE"

    mpc single off
}

INFILE="/tmp/mustagger.in"
[ -f "$INFILE" ] || touch "$INFILE"

while true; do
    input="$(head -n 1 "$INFILE")"

    if [ -n "$input" ]; then
        echo "got input $input"
        handle_request "$input"
        sed -i 1d "$INFILE"
        echo "awaiting input from '$INFILE'"
        drop
    else
        sleep 1
    fi
done
''
