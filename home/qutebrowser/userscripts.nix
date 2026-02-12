{
    "qutebrowser/userscripts/pass.sh" = {
        executable = true;
        text = '' #!/usr/bin/env bash

        echo "hint inputs -f" >> "$QUTE_FIFO" # opens the first field
        pw "$@"
        '';
    };

    "qutebrowser/userscripts/browseshell.sh" = {
        executable = true;
        text = '' #!/usr/bin/env bash
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
                    searchout="$(xio "${"$\{query%% *\}"}s")"

                    if [ -z "$searchout" ];
                    then default
                    else open "$searchout$(encode "${"$\{query#* \}"}")"; fi
                    ;;
            esac
        }

        function get_query() {
            hist="$(
                /home/canoe/repos/xioxide/main.sh parsed sites | awk '{ gsub(/_/, "", $1); print }'
                tac "$BROWSESHELL_HIST"
            )"

            fzout="$(echo "$hist" | menu --print-query)"

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
        '';
    };

    # note: the below script is rerun on hyprland reload
    "qutebrowser/userscripts/urlupdater.sh" = {
        executable = true;
        text = ''
        #!/usr/bin/env bash
        # ensure we are the only running instance
        kill $(ps aux | grep 'bash [^ ]*qutebrowser/userscripts/urlupdater.sh' | grep -v $$ | awk '{ print $2 }')

        infile="/tmp/qute_geturl.out"
        outfile="/tmp/qute_url"
        touch "$outfile"

        while true; do
            qutebrowser ":spawn --userscript geturl.sh" # blocks for ~0.4s
            cat "$infile" > "$outfile"
        done
        '';
    };

    "qutebrowser/userscripts/geturl.sh" = {
        executable = true;
        text = '' #!/usr/bin/env bash
        echo "$QUTE_URL" > "/tmp/qute_geturl.out" '';
    };

    "qutebrowser/userscripts/translate.sh" = {
        executable = true;
        text = '' #!/usr/bin/env bash
        while [[ $# > 0 ]]; do
            case $1 in
                -s|--source)
                    QUTE_TRANS_SOURCE=$2
                    shift
                    shift
                    ;;
                -t|--target)
                    QUTE_TRANS_TARGET=$2
                    shift
                    shift
                    ;;
                --url)
                    QUTE_TRANS_URL="true"
                    shift
                    ;;
                --text)
                    QUTE_TRANS_URL="false"
                    shift
                    ;;
            esac
        done

        if [[ -z $QUTE_TRANS_SOURCE ]]; then
            # Default use automatic language for source
            QUTE_TRANS_SOURCE="auto"
        fi
        if [[ -z $QUTE_TRANS_TARGET ]]; then
            # Default use English for target
            QUTE_TRANS_TARGET="en"
        fi

        if [[ $QUTE_TRANS_URL == "false" ]]; then
            # Translate selected text
            PAGE="https://translate.google.com/#view=home&op=translate&"
            CONT_KEY="text"
            CONTENT=$QUTE_SELECTED_TEXT
        else
            # Default translate URL
            PAGE="https://translate.google.com/translate?"
            CONT_KEY="u"
            CONTENT=$QUTE_URL
        fi

        echo "open -t ${"$\{PAGE\}"}sl=$QUTE_TRANS_SOURCE&tl=$QUTE_TRANS_TARGET&$CONT_KEY=$CONTENT" >> "$QUTE_FIFO"
        '';
    };
}
