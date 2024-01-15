{ config, ... }:
let
    private = "${config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR}/nix-dots/private";
in
/* bash */ ''
echo "clearing firefox build"
out="$(rm -rfv "${private}/firefox-build/")"
echo "$out" | head
echo

echo "pulling runtime config from ~/.mozilla"
out="$(cp -rv ~/.mozilla/ "${private}/firefox-build/")"
echo "$out" | head
echo

echo "overlaying generated files"
out="$(cp -rv "${private}/firefox-main"/* "${private}/firefox-build/firefox/main/")"
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
