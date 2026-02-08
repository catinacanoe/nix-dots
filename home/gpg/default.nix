{ config, pkgs, ... }:
let
    gpgdir = "${config.home.homeDirectory}/.gnupg";
    timeout = 60*60*24*3; # 3 days
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
        pinentry.package = pkgs.pinentry-qt; # see docs
        enableSshSupport = true; # more research into opt required
        # theres some enable<shell>Integration, see docs ig

        defaultCacheTtl = timeout; # seconds
        defaultCacheTtlSsh = timeout;
        maxCacheTtl = timeout;
        maxCacheTtlSsh = timeout;

        extraConfig = "allow-loopback-pinentry";
    };
}
