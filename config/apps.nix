{ config, pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs;
    let
        hypr = writeShellScriptBin "hypr" "source ~/.profile && Hyprland";
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
    
        # user apps
        neovim nvimpager
        firefox ungoogled-chromium qutebrowser
	networkmanagerapplet iwgtk
	protonvpn-cli_2

        kitty
        mpv-unwrapped
        tofi
        neomutt
        htop-vim

	#cloudflare-warp # https://developers.cloudflare.com/warp-client/get-started/linux/
    
        # core system apps
        hyprland hypr
        pulseaudio pipewire
        waybar
        swww
    ];
}
