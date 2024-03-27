{ pkgs, ... }: pkgs.writeShellScriptBin "mustagger" ''
TARGETFOLDER="new"
TARGETPATH="$XDG_MUSIC_DIR/$TARGETFOLDER"
INDEXFILE="$XDG_MUSIC_DIR/meta/index"
TAGFILE="$XDG_MUSIC_DIR/meta/tags"

function get_file() {
    local input="$1"
    [ -z "$input" ] && echo "ERROR: get_file: please pass input" && return
    local target

    if echo "$input" | grep -q 'http'; then
        local name="$(yt-dlp --skip-download --get-title --no-warnings "$input")"
        target="$TARGETPATH/$name.mp3"
        yt-dlp -o "$target" -x --audio-format mp3 --audio-quality 0 "$input" &> /dev/null

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

    local tag
    local response="$(cat "$INDEXFILE" | sed 's|^.* /// ||' | tr ' ' '\n' | grep "^$letter=" | sed "s|^$letter=||" | sort | uniq | fzf --print-query)"
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

        local letter="$(echo "$letterlist" | sort | fzf | sed 's|^\(.\) *$|\1|')"
        [ -z "$letter" ] && break

        if echo "$single_letters" | grep -q "$letter"; then
            local tag="$(mk_tag "$letter")"
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
                local tag="$(mk_tag "$letter")"
                [ -z "$tag" ] && break
                taglist="$(
                    [ -n "$taglist" ] && echo "$taglist"
                    echo "$letter=$tag"
                )"
            done
        fi
    done

    local doublecheck="$(mktemp)"
    echo "$taglist" | tr '\n' ' ' > "$doublecheck"
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

    start_playback "$TARGETFOLDER/$targetstem.mp3"

    # get all the tags
    local taglistfile="$(mk_taglist)"
    $EDITOR "$taglistfile"
    local taglist="$(head -n 1 "$taglistfile" | sed -e 's|\s*$||' -e 's|^\s*||')"
    echo "$targetstem /// $taglist" >> "$INDEXFILE"

    mpc single off
}

handle_request "$1"

INFILE="/tmp/mustagger.in"
[ -f "$INFILE" ] || touch "$INFILE"

while true; do
    input="$(head -n 1 "$INFILE")"

    if [ -n "$input" ]; then
        handle_request "$input"
        sed -i 1d "$INFILE"
        echo "awaiting input from '$INFILE'"
    else
        sleep 1
    fi
done
''
