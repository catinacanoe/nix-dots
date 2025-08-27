{ ... }: {
    # this is NOT IN USE
    # reference in default.nix is commented
    # this option is only available in more up to date nixpkgs

    services.qbittorrent = {
        enable = true;
        serverConfig.BitTorrent.Session = let
            interface = builtins.replaceStrings ["\.conf"] [""] (builtins.elemAt (builtins.attrNames (builtins.readDir ../private/wireguard)) 0);
        in {
            Interface = interface;
            InterfaceName = interface;
        };
    };
}
