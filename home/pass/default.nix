{ config, pkgs, ...}:
{
    programs.password-store = {
        enable = true;
        package = pkgs.pass; # can add extensions here, see mynixos
        settings = {
            PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.pass";
            #PASSWORD_STORE_UMASK = "" to change the umask from 077
        };
    };
}
