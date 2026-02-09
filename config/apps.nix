{ config, pkgs, inputs, ... }@args:
{
    environment.pathsToLink = [ "/share/zsh" ]; # ZSH comp requirement

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs;
    let
        netshell    = (import ./custom/netshell.nix args);
        nixshell    = (import ./custom/nixshell.nix args);
        setbright   = (import ./custom/setbright.nix args);
        yargs       = (import ./custom/yargs.nix args);
    in [
        ###############
        # CUSTOM APPS #
        ###############
        netshell
        nixshell
        setbright
        yargs

        #############
        # CLI UTILS #
        #############
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
        # catimg
        cbonsai
        cmatrix
        cdrtools
        diff-so-fancy
        expect
        exfat
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
        libinput-gestures
        libnotify
        mediainfo
        mkvtoolnix
        mlocate
        mpc
        neofetch
        newsboat
        ntfs3g
        nurl
        odt2txt
        p7zip
        parted
        pdftk
        gparted
        pavucontrol
        pciutils
        pipx
        powertop
        powerstat
        upower
        procps
        pipes
        psmisc
        qastools
        qrcode
        ripgrep
        shellcheck
        seatd
        slurp
        speedtest-cli
        starship
        sysfsutils
        tldr
        trash-cli
        tty-clock
        unrar
        unzip
        unzip
        mysql80
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
        dragon-drop
        xz
        yt-dlp
        zip
        zsteg

        # nvidia compat

        #############
        # LIBRARIES #
        #############
        # python311Full
        python311Packages.docx2txt
        # python311Packages.howdoi (breaks 24.11 build)

        clang boost ncurses tomlplusplus
        # qt6ct

        lua

        zulu # java

        # manpages ???
        stdmanpages clang-manpages llvm-manpages

        # cursor
        bibata-cursors phinger-cursors

        ### CORE TUI APPS
        kitty xterm
        zsh
        neovim nvimpager
        lf
        libqalculate
        neomutt
        rclone

        ####################
        # CORE SYSTEM APPS #
        ####################
        # hyprland
        pulseaudio pipewire
        waybar
        eww
        swaylock-effects
        mako
        swww
        mpd
        gtk3
        networkmanagerapplet wireguard-tools
    ];
}
