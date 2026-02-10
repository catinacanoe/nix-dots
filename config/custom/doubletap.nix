{ pkgs, ... }: pkgs.writeShellScriptBin "doubletap" ''
# example call
# doubletap airpod 150 "plyr toggle" "plyr next" "plyr prev'"
# (plyr is a script I have for media controls)
# basically "airpod" is the ID for this key, so that other doubletaps can run independently of this one
# 150 is the timeout, so the key presses must occur within 150ms of each other
# what follows is a list of commands to run, so on one tap: play/pause, two taps: next, three taps: prev etc

# calling doubletap with the same ID as previous call but different timeout is undefined behavior

id="$1"
timeout="$2"

counter_file="/tmp/doubletap-$id.counter" # contains how many times this has been pressed (without timing out)
[ ! -f "$counter_file" ] && echo 0 > "$counter_file"

# record that the command has been run again (increment counter file)
counter="$(cat "$counter_file")"
counter="$((counter+1))"
echo "$counter" > "$counter_file"

argnum="$((counter+2))" # because the 1st command is in 3rd argument
${"command=\"$\{!argnum\}\""} # fucked syntax bc this is in nix

sleep "$(echo "scale=3; $timeout/1000" | bc)" && [ "$counter" == "$(cat "$counter_file")" ] && $command && echo 0 > "$counter_file" &
''
