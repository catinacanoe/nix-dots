{ config, ... }:
let
    gpgdir = "${config.home.homeDirectory}/.gnupg";
    timeout = 60*60*5;
in
{
    programs.gpg = {
        enable = true;
        homedir = gpgdir;
        settings = {
            homedir = gpgdir;
        }; # the gpg flags, see gpg manpage and nix docs
    };

    services.gpg-agent = {
        enable = true;
        pinentryFlavor = "qt"; # see docs
        enableSshSupport = true; # more research into opt required
        # theres some enable<shell>Integration, see docs ig

        defaultCacheTtl = timeout; # seconds
        defaultCacheTtlSsh = timeout;
        maxCacheTtl = timeout;
        maxCacheTtlSsh = timeout;

        extraConfig = "";
    };
}
