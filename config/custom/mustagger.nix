{ pkgs, ... }: pkgs.writeShellScriptBin "mustagger" ''
TARGETFOLDER="dl"
TARGETPATH="$XDG_MUSIC_DIR/$TARGETFOLDER"
TAGFILE="$XDG_MUSIC_DIR/meta/tag"
INDEXFILE="$XDG_MUSIC_DIR/meta/index"

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
    local original="$1"

    local file="/tmp/$original.tmp"
    echo "Rename this file (leave only one line):" > "$file"
    echo "$(basename "$original" | sed -s 's|\.[^.]*$||')" >> "$file"

    cat "$file" | head -n 1
}

function mk_taglist() {
    local single_letters="$(echo 'l b c e r' | tr ' ' '\n')"
    local multi_letters="$(echo 'a g' | tr ' ' '\n')"
    local taglist

    while true; do
        # select a letter
        local letter='a'

        if echo "$single_letters" | grep -q "$letter"; then
            local tag
            local response="$(cat "$INDEXFILE" | grep "^$letter=" | sed "s|^$letter=||" | fzf --print-query)"
            local query="$(echo "$response" | head -n 1)"
            local selected="$(echo "$response" | sed -n 2p)"

            if [ -z "$selected" ]

        elif echo "$multi_letters" | grep -q "$letter"; then
        fi
    done
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
        echo "ERROR: file not in mp3 format"
        return
    fi

    # rename file
    local targetstem="$(rename_file "$filename")" # the result of the renaming
    local targetname="$TARGETPATH/$targetstem.mp3" # the new full path
    if [ -z "$targetstem" ]; then
        echo "ERROR: handle_request: renamed filename is empty"
        return
    fi
    mv "$filename" "$targetname"

    start_playback "$TARGETFOLDER/$targetstem.mp3"

    # get all the tags
    local taglist="$(mk_taglist)"
}
''
