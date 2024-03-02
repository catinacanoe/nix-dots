#!/usr/bin/env bash

sleep 2

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]; do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# make sure to clean pipe
pipe="/tmp/cava.fifo"
if [ -p $pipe ]; then
    unlink $pipe
fi
mkfifo $pipe

# write cava config
config_file="/tmp/eww_cava_config"
echo "
[general]
autosens=1
bars=12
framerate=20
higher_cutoff_freq=10000
lower_cutoff_freq=35

[output]
channels=mono
method=raw
raw_target=$pipe
data_format=ascii
ascii_max_range=7
mono_option=average
orientation=bottom
" > $config_file

# run cava in the background
kill "$(ps aux | grep "cava -p $config_file" | awk '{ print $2 }')"
sleep 0.5
cava -p $config_file &

# reading data from fifo
while read -r cmd; do
    eww update "var_cava=$(echo "$cmd" | sed "$dict")"
done < $pipe
