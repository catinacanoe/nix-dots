{ pkgs, ... }: pkgs.writeShellScriptBin "browseshell" ''

BROWSESHELL_HIST="/tmp/browseshell.hist"
touch $BROWSESHELL_HIST

function encode() {
    local escape="$(echo "$@" | sed 's|"|\"|g')"
    python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(\"$escape\"))"
}

function open() {
    wl-copy "$@"
    # hyprctl dispatch focuscurrentorlast &> /dev/null
    drop browseshell nohistory

    local class="$(hyprctl activewindow -j | jq .class)"
    if [ "$class" == "\"$BROWSER\"" ] || echo "$class" | grep -qi 'browser'; then
        true
    else
        return
    fi

    title="$(hyprctl activewindow -j | jq .title)"

    if [ "$BROWSER" == "firefox" ] && [ "$title" == '"Mozilla Firefox"' ]; then
        wtype -M ctrl -k l -m ctrl
    elif [ "$BROWSER" == "chromium" ] && [ "$title" == '"New Tab - Chromium"' ]; then
        wtype -M ctrl -k l -m ctrl
    else
        wtype -M ctrl -k t -m ctrl
    fi

    sleep 0.15
    wtype -M ctrl -k v -m ctrl
    sleep 0.15
    wtype -k Return
}

function default() {
    open "google.com/search?q=$(encode "$query")"
}

function xio() {
    source /home/canoe/repos/xioxide/main.sh "" "" echo "" sites "$@" --no-passthrough
}

function handle_query() {
    case "$(echo "$query" | wc -w)" in
        0) true ;;
        1) 
            out="$(xio "$query")"
            if [ -z "$out" ]; then # there was no match
                default
            else
                open "$out"
            fi
            ;;
        *)
            out="$(xio "$(echo "$query" | awk '{ print $1 }')")"
            if [ -z "$out" ]; then # there was no match
                default
            else
                # there was a match, must search under this xioxide entry
                searchout="$(xio "$(echo "$query" | awk '{ print $1 }')s")"
                if [ -z "$searchout" ]; then
                    # no searching subentry, fallback
                    default
                else
                    search="$(echo "$query" | sed 's|^[^ ]* ||')"
                    open "$searchout$(encode "$search")"
                fi
            fi
            ;;
    esac
}

function get_query() {
    hist="$(
        while IFS= read -r line; do
            local first="$(echo "$line" | awk '{ print $1 }')"
            local rest="$(echo "$line" | awk '{ for (i=2; i<=NF; i++) print $i }')"
            local first_no_under="$(echo "$first" | sed 's/_//g')"
            echo "$first_no_under $rest"
        done <<< "$(/home/canoe/repos/xioxide/main.sh parsed sites)"
        tac "$BROWSESHELL_HIST"
    )"

    fzout="$(echo "$hist" | fzf --print-query)"

    if [ -z "$(echo "$fzout" | head -n 1)" ]; then
        prequery="$(echo "$fzout" | tail -n 1)"
        if echo "$prequery" | grep -q " \*$"; then
            query="$(echo "$prequery" | sed 's/ \*$//')"
        else
            query="$(echo "$prequery" | awk '{ print $1 }')"
        fi
    elif echo "$fzout" | head -n 1 | grep -q "\*$"; then
        query="$(echo "$fzout" | tail -n 1 | sed 's/ \*$//')"
    else
        query="$(echo "$fzout" | head -n 1)"
        [ "$query" == ":q" ] && exit
        if ! grep -q "$query *" "$BROWSESHELL_HIST"; then # not already in history
            if [ -z "$(xio "$query")" ]; then # not a xioxide entry
                echo "$query *" >> "$BROWSESHELL_HIST"
            fi
        fi
    fi
}

if [ -n "$1" ] && [ "$1" != "--pypr" ]; then
    query="$@"
    handle_query
    exit
fi

while true ; do
    get_query
    handle_query
done
''
