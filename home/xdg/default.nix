{ config, ... }:
let
    home = config.home.homeDirectory;
    local = "${home}/.local";
in
{
    xdg = {
        enable = true;
        mime.enable = true;

        configHome = "${home}/.config";
        dataHome = "${local}/share";
        stateHome = "${local}/state";
        cacheHome = "${local}/cache";

        userDirs = {
            enable = true;
            createDirectories = false;

            download = "${home}/dl";
            music = "${home}/mus";
            videos = "${home}/vid";
            pictures = "${home}/pix";
            documents = "${home}/dox";

            publicShare = "${local}/public";
            desktop = "${home}/public/desktop";
            templates = "${local}/public/templates";

            extraConfig = {
                XDG_REPOSITORY_DIR = "${home}/repos";
            };
        };

        mimeApps = {
            enable = true;
            defaultApplications = {
                "x-scheme-handler/http" = [ "firefox.desktop" ];
                "x-scheme-handler/https" = [ "firefox.desktop" ];
            };
            associations.removed = { # remove associations forced by some apps
                #"mimetype1" = "shittyapp.desktop";
            };
        };
    };
}
