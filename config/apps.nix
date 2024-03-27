{ config, pkgs, ... }@args:
{
    environment.pathsToLink = [ "/share/zsh" ]; # ZSH comp requirement

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs;
    let
        browse      = (import ./custom/browse.nix args);
        browseshell = (import ./custom/browseshell.nix args);
        drop        = (import ./custom/drop.nix args);
        hypr        = (import ./custom/hypr.nix args);
        launcher    = (import ./custom/launcher.nix args);
        manpager    = (import ./custom/manpager.nix args);
        menu        = (import ./custom/menu.nix args);
        mptoggle    = (import ./custom/mptoggle.nix args);
        mustagger   = (import ./custom/mustagger.nix args);
        netshell    = (import ./custom/netshell.nix args);
        nixshell    = (import ./custom/nixshell.nix args);
        player      = (import ./custom/player.nix args);
        setbright   = (import ./custom/setbright.nix args);
        setvol      = (import ./custom/setvol.nix args);
        sshkey      = (import ./custom/sshkey.nix args);
        vpnshell    = (import ./custom/vpnshell.nix args);
        yargs       = (import ./custom/yargs.nix args);
    in [
        # custom apps
        browse
        browseshell
        drop
        launcher
        manpager
        menu.ui
        menu.wrap
        mptoggle
        mustagger
        netshell
        nixshell
        player
        setbright
        setvol
        sshkey
        vpnshell
        yargs

        # cli utils
        acpi
        ansifilter
        ascii-image-converter
        asciiquarium-transparent
        aalib
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
        cmatrix
        cdrtools
        diff-so-fancy
        expect
        exiftool
        eza
        fd
        socat
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
        pipes
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
        wget
        playerctl
        wl-clipboard
        wtype
        gdb
        crunch
        ghidra
        xdg-utils
        system-config-printer
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
        kitty
        mpv-unwrapped
        tofi
        neomutt
        sioyek
        zsh
        zoom-us

        # core system apps
        hyprland
        hypr pyprland
        pulseaudio pipewire
        waybar
        eww-wayland
        swaylock-effects
        mako
        swww
        mpd
    ];
}
