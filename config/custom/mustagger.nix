{ pkgs, ... }: pkgs.writeShellScriptBin "mustagger" ''
function get_file() {
    local input="$1"
    [ -z "$input" ] && echo "ERROR: get_file: please pass input" && return
    local target

    if echo "$input" | grep -q 'http'; then
        local name="$(yt-dlp --skip-download --get-title --no-warnings "$input")"
        target="$XDG_MUSIC_DIR/dl/$name.mp3"
        yt-dlp -o "$target" -x --audio-format mp3 --audio-quality 0 "$input" &> /dev/null

    elif [ -f "$input" ]; then
        target="$XDG_MUSIC_DIR/dl/$(basename "$input")"
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
function stop_playback() {
    local originalname="$1"
    local finalname="$2"
    [ -z "$finalname" ] && echo "ERROR: stop_playback: please pass final filename" && return
    [ -z "$originalname" ] && echo "ERROR: stop_playback: please pass original filename" && return

    mpc del 0
    mpc update

    rm "$originalname"

    mpc insert "$finalname"
    mpc play
    mpc next
    mpc single off
}

function rename_file() {
    local original="$1"

    local file="$(mktemp)"
    echo "Rename this file (leave only one line):" > "$file"
    echo "$(basename "$original" | sed -s 's|\.[^.]*$||')" >> "$file"

    cat "$file" | head -n 1
}

function handle_request() {
    local input="$1"

    local filename

    filename="$(get_file "$input")"
    if echo "$filename" | grep -q "^ERROR: "; then
        echo "$filename"
        return
    fi

    start_playback "$filename"
    
    local targetstem="$(rename_file "$filename")"
    if [ -z "$targetstem" ]; then
        echo "ERROR: handle_request: renamed filename is empty"
        return
    fi



    # move the file to $targetstem


stop_playback "$targetnxxxxxxxxxxxxxame"; }
''
