{ config, ... }:
let
    home = config.home.homeDirectory;
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
in
{
    programs.bash = {
        enable = true;
	shellAliases = {
            hm = "home-manager switch --flake path:${repos}/nix-dots/";
            nx = "sudo nixos-rebuild switch --flake path:${repos}/nix-dots/";

            sw = "swww";
            swki = "swww kill";
            swin = "swww init";
            swi = "swww img -t wipe";

            vpn = "sudo protonvpn";

	    en = "e ~";
	    o = "e ..";
	    oo = "e ../..";
	    ooo = "e ../../..";
	    oooo = "e ../../../..";
	    ooooo = "e ../../../../..";
	    oooooo = "e ../../../../../..";
        };
	initExtra = ''
	e() {
	    xioxide cd "grep '/$'" pwd dirs $@ && ls -al
	}
	h() {
	    xioxide "$EDITOR" "" pwd dirs $@
	}
	w() {
	    xioxide "$EDITOR" "" pwd dirs w$@
	}
	'';
    };
}
