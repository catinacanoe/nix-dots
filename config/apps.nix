{ config, pkgs, ... }@args:
{
    environment.pathsToLink = [ "/share/zsh" ]; # ZSH comp requirement

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs;
    let
        hypr = writeShellScriptBin "hypr" "Hyprland";

        browse =      (import ./custom/browse.nix args);
        browseshell = (import ./custom/browseshell.nix args);
        drop =        (import ./custom/drop.nix args);
        launcher =    (import ./custom/launcher.nix args);
        manpager =    (import ./custom/manpager.nix args);
        menu =        (import ./custom/menu.nix args);
        netshell =    (import ./custom/netshell.nix args);
        nixshell =    (import ./custom/nixshell.nix args);
        vpnshell =    (import ./custom/vpnshell.nix args);
        yargs =       (import ./custom/yargs.nix args);
    in [
        # custom apps
        browse
        browseshell
        drop
        launcher
        manpager
        menu.ui
        menu.wrap
        netshell
        nixshell
        vpnshell
        yargs

        # cli utils
        ansifilter
        ascii-image-converter
        at
        audiowaveform
        bat
        bc
        bind
        bintools-unwrapped
        binwalk
        brightnessctl
        catdoc
        catimg
        cbonsai
        cdrtools
        diff-so-fancy
        exiftool
        eza
        fd
        ffmpeg
        ffmpegthumbnailer
        file
        fzf
        gcc
        git
        gnumake
        gnumeric
        gotop
        grim
        imagemagick
        imgurbash2
        imv
        isync
        iw
        jc jq
        libcaca
        libnotify
        mediainfo
        mlocate
        mpc-cli
        neofetch
        newsboat
        odt2txt
        p7zip
        pavucontrol
        pciutils
        pipx
        poppler_utils
        procps
        psmisc
        ripgrep
        shellcheck
        slurp
        speedtest-cli
        starship
        sysfsutils
        thefuck
        tldr
        trash-cli
        tty-clock
        unrar
        unzip
        unzip
        viu
        wev
        wirelesstools
        wl-clipboard
        wtype
        xdg-utils
        xdragon
        xz
        yt-dlp
        zsteg

        # nvidia compat
        qt5ct
        libva

        # lib
        python311Full
        python311Packages.docx2txt
        python311Packages.howdoi

        clang_15 boost183 ncurses

        zulu # java

        # manpages ???
        stdmanpages clang-manpages llvm-manpages

        # cursor
        bibata-cursors phinger-cursors
    
        # user apps
        neovim nvimpager
        firefox ungoogled-chromium
        networkmanagerapplet protonvpn-cli_2
        lf libqalculate
        (discord.override { # https://nixos.wiki/wiki/Discord
            withVencord = true;
        })
        cava
        lunar-client
        kitty
        mpv-unwrapped
        tofi
        neomutt
        sioyek
        zsh

        # core system apps
        hyprland
        hypr pyprland
        pulseaudio pipewire
        waybar
        swaylock-effects
        mako
        swww
        mpd
    ];
}
