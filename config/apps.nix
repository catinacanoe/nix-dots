{ config, pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    environment.pathsToLink = [ "/share/zsh" ]; # ZSH comp requirement

    environment.systemPackages = with pkgs;
    let
        hypr = writeShellScriptBin "hypr" "source $ZDOTDIR/.zshenv && Hyprland";
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

	# lib
	python311Full
	python311Packages.docx2txt
    
        # user apps
        neovim nvimpager
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
	mako
        swww
    ];
}
