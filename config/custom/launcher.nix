{ pkgs, ... }: pkgs.writeShellScriptBin "launcher" ''
MAX_RECENTS=7

function update_recents() {
    # bottom is newest
    RECENT_LAUNCHES="$(
        if echo "$RECENT_LAUNCHES" | grep -q "^$program$"; then
            # list already has this entry, move it to bottom
            echo "$RECENT_LAUNCHES" | sed "/^$program$/d"
        elif [ "$(echo "$RECENT_LAUNCHES" | wc -l)" -ge $MAX_RECENTS ]; then
            # we need to remove one entry
            echo "$RECENT_LAUNCHES" | tail -n +2
        else
            # we can just add another entry
            echo "$RECENT_LAUNCHES"
        fi

        echo "$program"
    )"
}

function construct_list() {
    find ${"\${PATH//:/ }"} -maxdepth 1 -executable 2>/dev/null | awk -F "/" '{ print $NF }' | sort | grep -v "\[\|^\." # no "[" or leading dot "^."

    if [ -n "$RECENT_LAUNCHES" ]; then
        echo "$RECENT_LAUNCHES"
    fi
}

SAVE_FILE=/tmp/launcher.recents

touch $SAVE_FILE
RECENT_LAUNCHES="$(cat $SAVE_FILE)"

program="$(construct_list | tac | fzf)"
[ -z "$program" ] && exit

update_recents
echo "$RECENT_LAUNCHES" > $SAVE_FILE

"$program"
''
