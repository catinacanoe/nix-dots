{ config, pkgs, ... }:
{
    environment.pathsToLink = [ "/share/zsh" ]; # ZSH comp requirement

    nixpkgs.config = {
        allowUnfree = true;
    };

    environment.systemPackages = with pkgs;
    let
        hypr = writeShellScriptBin "hypr" "Hyprland";
        zargs = writeShellScriptBin "zargs" ''
        [ "$1" == "-E" ] && esc="$2" && shift 2 || esc="%%%"
        eval "$(cat | sed "s|$esc|$@|g")"
	'';
    in
    [
        # cli utils
        speedtest-cli
        yt-dlp
        pciutils
        sysfsutils
        iw
        wirelesstools
        pavucontrol
        procps
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
	zargs
	shellcheck

	# lib
	python311Full
	python311Packages.docx2txt
    
        # user apps
        neovim brave nvimpager
        firefox ungoogled-chromium
	networkmanagerapplet protonvpn-cli_2
	lf

        kitty
        mpv-unwrapped
        tofi
        neomutt
        htop-vim
	zsh

        # core system apps
        hyprland hypr
        pulseaudio pipewire
        waybar
	swaylock-effects
	mako
        swww
    ];
}
