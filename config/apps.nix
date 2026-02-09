{ config, pkgs, inputs, ... }@args:
{
    environment.pathsToLink = [ "/share/zsh" ]; # ZSH comp requirement

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs;
    let
        blueshell = (import ./custom/blueshell.nix args);
        browser     = (import ./custom/browser.nix args);
        browseshell = (import ./custom/browseshell.nix args);
        doubletap   = (import ./custom/doubletap.nix args);
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
        plyr        = (import ./custom/plyr.nix args);
        setbright   = (import ./custom/setbright.nix args);
        setvol      = (import ./custom/setvol.nix args);
        sshkey      = (import ./custom/sshkey.nix args);
        vimit       = (import ./custom/vimit.nix args);
        vpnshell    = (import ./custom/vpnshell.nix args);
        yargs       = (import ./custom/yargs.nix args);
        notion-app-custom  = (callPackage ./custom/notion-app.nix {});
        # spicetify = inputs.spicetify-nix.lib.mkSpicetify pkgs (import ./spicetify.nix args);
    in [
        ###############
        # CUSTOM APPS #
        ###############
        blueshell
        browser
        browseshell
        doubletap
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
        plyr
        setbright
        setvol
        sshkey
        vimit
        vpnshell
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
        poppler-utils
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
        libsForQt5.qt5ct
        libva

        #############
        # LIBRARIES #
        #############
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
    
        #############
        # USER APPS #
        #############

        ### BROWSERS
        google-chrome
        brave
        qutebrowser
        # firefox 

        ### CORE TUI APPS
        kitty xterm
        zsh
        neovim nvimpager
        lf
        libqalculate
        neomutt
        rclone

        ### CREATIVE APPS
        obsidian
        notion-app-custom
        kicad
        spotify spotify-cli-linux
        krita
        gimp
        # lunar-client DOESNT RUN ON WAYLAND

        ### COMMUNICATION
        zoom-us
        slack
        qbittorrent

        ### FILE VIEWERS
        mpv-unwrapped mpvc
        sioyek mcomix

        # bloat, arguably
        dysk # df enhancement
        cava

        ####################
        # CORE SYSTEM APPS #
        ####################
        hyprland
        hypr pyprland
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
