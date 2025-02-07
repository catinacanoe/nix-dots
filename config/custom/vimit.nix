{ pkgs, ... }: pkgs.writeShellScriptBin "vimit" ''
VIMIT_SLEEPTIME=0.3

# copy text
sleep $VIMIT_SLEEPTIME
wtype -M ctrl -k c -m ctrl
sleep $VIMIT_SLEEPTIME

# paste into tmp file
file="$(mktemp vimit.XXXXXXXXXX --tmpdir)"
wl-paste -n > "$file"

# open a terminal solely running vim on that file
kitty sh -c "nvim $file -c ':set wrap'"

# on close, copy contens of file and paste (assume focus returns to correct window)
cat "$file" | wl-copy -n

sleep $VIMIT_SLEEPTIME
wtype -M ctrl -k V -m ctrl
''
