#!/usr/bin/env bash

# WARN YOU MUST CALL `drop menu nohistory` BEFORE CALLING THIS SCRIPT
# we pass --menui-is-open to menu, WE EXPECT THE DROPDOWN TO BE OPEN
# this is done for optimization: open the menu before we have the list of options

BROWSESHELL_HIST="/tmp/browseshell.hist"
touch $BROWSESHELL_HIST > /dev/null

function encode() {
    local escape="$(echo "$@" | sed 's|"|\"|g')"
    python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(\"$escape\"))"
}

function open() {
    echo "open -t $@" >> "$QUTE_FIFO"
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
            if [ -z "$out" ]; then default
            else open "$out"; fi
            ;;
        *)
            searchout="$(xio "${query%% *}s")"

            if [ -z "$searchout" ];
            then default
            else open "$searchout$(encode "${query#* }")"; fi
            ;;
    esac
}

function get_query() {
    hist="$(
        /home/canoe/repos/xioxide/main.sh parsed sites | awk '{ gsub(/_/, "", $1); print }'
        tac "$BROWSESHELL_HIST"
    )"

    # WE ASSUME THE `menu` dropdown IS OPEN (`drop menu nohistory` has been called)
    # so we pass --menuui-is-open
    fzout="$(echo "$hist" | menu --menuui-is-open --print-query)"

    if [ -z "$(echo "$fzout" | head -n 1)" ]; then # we just chose sum, no type
        prequery="$(echo "$fzout" | tail -n 1)"
        if echo "$prequery" | grep -q " \*$"; then
            query="$(echo "$prequery" | sed 's/ \*$//')"
        else
            query="$(echo "$prequery" | awk '{ print $1 }')"
        fi
    elif echo "$fzout" | head -n 1 | grep -q "\*$"; then # we selected hist w/ *
        query="$(echo "$fzout" | tail -n 1 | sed 's/ \*$//')"
    else # we typed something, not selecting history though
        query="$(echo "$fzout" | head -n 1)"
        [ "$query" == ":q" ] && exit
        if ! grep -q "$query *" "$BROWSESHELL_HIST"; then # not already in history
            if [ -z "$(xio "$query")" ]; then # not a xioxide entry
                echo "$query *" >> "$BROWSESHELL_HIST"
            fi
        fi
    fi
}

get_query
handle_query
