{ config, pkgs, ... }@args:
{
    environment.pathsToLink = [ "/share/zsh" ]; # ZSH comp requirement

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs;
    let
        hypr = writeShellScriptBin "hypr" "Hyprland";
        vp = (import ./custom/vpnshell.nix args);
        browsepad = (import ./custom/browsepad.nix args);
        browse = (import ./custom/browse.nix args);
        nixshell = (import ./custom/nixshell.nix args);
        drop = (import ./custom/drop.nix args);
        yargs = writeShellScriptBin "yargs" ''
        [ "$1" == "-E" ] && esc="$2" && shift 2 || esc="%%%"
        eval "$(cat | sed "s|$esc|$@|g")"
        '';
    in
    [
        # cli utils
        vp
        drop
        browsepad
        nixshell
        browse
        yargs
        speedtest-cli
        yt-dlp
        pciutils
        sysfsutils
        iw
        wirelesstools
        pavucontrol
        procps
        fd
        psmisc
        wev
        libnotify
        ffmpeg
        mediainfo
        unzip
        brightnessctl
        tldr
        neofetch
        wtype
        jc jq
        isync
        bind
        bc
        at
        fzf
        ripgrep
        eza
        starship
        bat
        thefuck
        diff-so-fancy
        wl-clipboard
        file
        trash-cli
        xdragon
        exiftool
        gnumeric
        catdoc
        odt2txt
        cdrtools
        p7zip
        unrar
        unzip
        xz
        ascii-image-converter
        catimg
        viu
        libcaca
        poppler_utils
        ffmpegthumbnailer
        imagemagick
        audiowaveform
        shellcheck
        pipx
        imgurbash2
        gnumake
        mlocate
        xdg-utils
        bintools-unwrapped
        binwalk
        zsteg
        grim
        slurp
        htop-vim
        tty-clock
        cbonsai
        imv
        mpc-cli
        newsboat
        git
        gcc

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
