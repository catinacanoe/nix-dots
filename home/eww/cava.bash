#!/usr/bin/env bash

sleep 2

local bar="▁▂▃▄▅▆▇█"
local dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]; do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# make sure to clean pipe
local pipe="/tmp/cava.fifo"
if [ -p $pipe ]; then
    unlink $pipe
fi
mkfifo $pipe

