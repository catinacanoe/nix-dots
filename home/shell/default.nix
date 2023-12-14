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

	    o = "e ..";
	    oo = "e ../..";
	    ooo = "e ../../..";
	    oooo = "e ../../../..";
	    ooooo = "e ../../../../..";
	    oooooo = "e ../../../../../..";

	    n = "eza -a1lo --no-user --no-permissions --no-filesize --no-time";
	    t = "eza -T";

	    gp = "grep";
	    gpi = "grep -i";
        };
	initExtra = ''
	en() {
	    xioxide cd "grep '/$'" pwd dirs $@ && ls -al
	}
	e() {
	    xioxide cd "grep '/$'" pwd dirs $@
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
