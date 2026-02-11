/*bash*/''

function vdl() {
    if [ -n "$1" ]; then
        yt-dlp --format mp4 "$@"
    else
        yt-dlp --format mp4 "$(wl-paste)"
    fi
}
function adl() {
    if [ -n "$1" ]; then
        yt-dlp -x --audio-format mp3 --audio-quality 0 "$@"
    else
        yt-dlp -x --audio-format mp3 --audio-quality 0 "$(wl-paste)"
    fi
}

''
