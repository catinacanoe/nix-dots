{ config, pkgs, ... }:
let
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
in
{
    home.packages = [ (pkgs.writeShellScriptBin "pw" "${repos}/pw/main.sh $@") ];
}
