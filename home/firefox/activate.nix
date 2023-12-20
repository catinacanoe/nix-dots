{ config, ... }:
''
echo "removing files from ~/.mozilla"
rm -rf "${config.home.homeDirectory}/.mozilla" | head

echo "copying files from store to mozilla"
cp -r "${config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR}/nix-dots/private/firefox" "${config.home.homeDirectory}/.mozilla" | head
''
