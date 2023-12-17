{ config, inputs, ... }:
let
    home = config.home.homeDirectory;
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
in
{
    xdg.configFile."zsh/plugins" = {
	source = ./plugins;
	recursive = true;
    };

    programs.zsh = {
        enable = true;
	dotDir = ".config/zsh";

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
            hst = "tac $ZDOTDIR/.zsh_history | awk -F ';' '{ print $2 }' | fzf | tr -d '\\n' | wtype -";

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

	    k = "mkdir -p";
	    l = "touch";
	    m = "mv -i";
	    c = "cp -ri";
	    r = "trash-put";
	    z = "exit";

	    src = "exec zsh";

	    t = "eza -T";
	    n = "eza -a1lo --no-user --no-permissions --no-filesize --no-time";

	    gp = "grep";
	    gpi = "grep -i";
	};

	initExtra = with config.programs.zsh.shellAliases; ''
	eo() { cd - > /dev/null && ${n}; }
	e() { ${xioxide} cd "grep '/$'" pwd dirs $@ && ${n}; }
	h() { ${xioxide} "$EDITOR" "" pwd dirs $@; }
	w() { ${xioxide} "$EDITOR" "" pwd dirs w$@; }
	ke() { ${k} "$1" && e "$1"; }
	diff() { diff $@ -u | diff-so-fancy | less --tabs=4 -RF; }

	for plugin in $ZDOTDIR/plugins/pre/*.plugin.zsh; do
	    source "$plugin"
	done

	for plugin in $ZDOTDIR/plugins/*.plugin.zsh; do
	    zsh-defer source "$plugin"
	done
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

	bindkey '^[[Z' autosuggest-accept # shift tab
	bindkey '^I' expand-or-complete # tab
	'';
    };
}
