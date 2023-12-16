{ config, inputs, ... }:
let
    home = config.home.homeDirectory;
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;

    mkzsh = { group, name, file?"", sha256?"", ... }: {
        inherit name file;
	src = builtins.fetchTarball {
	    url = "https://github.com/${group}/${name}/archive/master.tar.gz";
	    inherit sha256;
	};
    };
in
{
    programs.zsh = {
        enable = true;
	dotDir = ".config/zsh";

	plugins = [
	    (mkzsh {
	        group = "MichaelAquilina";
	        name = "zsh-you-should-use";
		sha256 = "0qap4yxc9skk7sqcwjz9x4arkl51zqa9scch0c8zmixp2473mawl";
	    })
	];

	enableCompletion = true;
	enableAutosuggestions = true;
	syntaxHighlighting.enable = true;

	sessionVariables = {
	    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=7";
	};
        
	history = {
	    path = "$ZDOTDIR/.zsh_history";
	    size = 10000;
	    save = 10000;
	    extended = true;
	    share = true; # shared hist between files
	};

	shellAliases = {
            hm = "home-manager switch --flake path:${repos}/nix-dots/ && xioxide reload";
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

	initExtra = with config.programs.zsh.shellAliases; ''
	e() { ${xioxide} cd "grep '/$'" pwd dirs $@ && ${n}; }
	h() { ${xioxide} "$EDITOR" "" pwd dirs $@; }
	w() { ${xioxide} "$EDITOR" "" pwd dirs w$@; }
	'';

	completionInit = ''
	autoload -U compinit
	zstyle ':completion:*' menu select
	zmodload zsh/complist
	compinit
	_comp_options+=(globdots)

	bindkey -M menuselect 'n' vi-backward-char
	bindkey -M menuselect 'a' vi-up-line-or-history
	bindkey -M menuselect 'i' vi-down-line-or-history
	bindkey -M menuselect 'o' vi-forward-char

	bindkey '^I' autosuggest-accept # tab
	bindkey '^[[Z' expand-or-complete # S-tab
	'';
    };

    programs.bash = {
        enable = true;
	shellAliases = {
            hm = "home-manager switch --flake path:${repos}/nix-dots/ && xioxide reload";
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
	e() {
	    xioxide cd "grep '/$'" pwd dirs $@ && n
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
