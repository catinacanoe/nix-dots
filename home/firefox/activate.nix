{ config, ... }:
let
    private = "${config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR}/nix-dots/private";
in
/* bash */ ''
[ -n "$(pgrep firefox)" ] && echo "killing all firefox windows" && killall .firefox-wrapped

echo "clearing firefox build"
out="$(rm -rfv "${private}/firefox-build/")"
echo "$out" | head
echo

echo "pulling runtime config from ~/.mozilla"
out="$(cp -rv ~/.mozilla/ "${private}/firefox-build/")"
echo "$out" | head
out="$(rm -rf "${private}/firefox-build/firefox/scratch")"
out="$(rm -rf "${private}/firefox-build/firefox/gpt")"
out="$(cp -r "${private}/firefox-build/firefox/main" "${private}/firefox-build/firefox/scratch")"
out="$(cp -r "${private}/firefox-build/firefox/main" "${private}/firefox-build/firefox/gpt")"
echo

echo "overlaying generated files"
out="$(cp -rv "${private}/firefox-gen"/* "${private}/firefox-build/firefox/main/")"
out="$(cp -rv "${private}/firefox-gen"/* "${private}/firefox-build/firefox/scratch/")"
out="$(cp -rv "${private}/firefox-gen-nodecor"/* "${private}/firefox-build/firefox/gpt/")"
echo "$out" | head
echo

echo "removing files from ~/.mozilla"
out="$(rm -rf ~/.mozilla/)"
echo "$out" | head
echo

echo "copying files from store to mozilla"
out="$(cp -r "${private}/firefox-build" ~/.mozilla/)"
echo "$out" | head
echo
''
