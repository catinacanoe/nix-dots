{ config, pkgs, ... }:
let
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
in
{
    home.packages = [ (pkgs.writeShellScriptBin "crypt" "${repos}/crypt/main.sh $@") ];
    home.sessionVariables.CRYPT_RECIPIENT = "cryptgpg@mail.pulsarfruit.xyz";
}
