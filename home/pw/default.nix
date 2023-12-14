{ config, pkgs, ... }:
let
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
in
{
    home.packages = [ (pkgs.writeShellScriptBin "pw" "${repos}/pw/default.sh $@") ];

    home.sessionVariables.PW_PATH =
        "${repos}/pw";
}
