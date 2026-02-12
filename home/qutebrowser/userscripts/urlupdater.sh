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
