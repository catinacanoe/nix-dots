{ config, ... }@args:
let
    home = config.home.homeDirectory;
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
  
    inherit (import ../../rice) col;
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

        shellAliases =
        (import ./modules/git.nix args) //
        {
            nx = "sudo nixos-rebuild switch --flake path:${repos}/nix-dots/";
            hst = "tac $ZDOTDIR/.zsh_history | awk -F ';' '{ print $2 }' | fzf | tr -d '\\n' | wtype -";

            sw = "swww";
            swki = "swww kill";
            swin = "swww init";
            swi = "swww img -t wipe";

            vpn = "sudo protonvpn";

            o = "e ../";
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

            a = "lf";
            A = "lfcd";

            src = "exec zsh";

            t = "eza -Ta";
            n = "eza -a1lo --no-user --no-permissions --no-filesize --no-time";

            gp = "grep";
            gpi = "grep -i";
        };

        initExtraFirst = with config.programs.zsh.shellAliases; /* bash */ ''
        e() { ${xioxide} cd "grep '/$'" pwd dirs $@ && ${n}; }
        eo() { cd - > /dev/null && ${n}; }
        h() { ${xioxide} "$EDITOR" "" pwd dirs $@; }
        w() { ${xioxide} "$EDITOR" "" pwd dirs w$@; }
        ke() { ${k} "$1" && e "$1"; }
        dsf() { diff -u $@  | diff-so-fancy | less --tabs=4 -RF; }
        hm() {
            [ -z "$1" ] && arg="h" || arg="$1"

            handled=""

            if [[ "$arg" == *"h"* ]]; then
                home-manager switch --flake path:${repos}/nix-dots/ || return
                handled="true"
            fi

            if [[ "$arg" == *"f"* ]]; then
                echo -e "\nACTIVATING FIREFOX"
                ${import ../firefox/activate.nix args}
                handled="true"
            fi

            if [[ "$arg" == *"x"* ]]; then
                echo -e "\nACTIVATING XIOXIDE"
                ${import ../xioxide/activate.nix args}
                handled="true"
            fi

            if [ -z "$handled" ]; then
                home-manager --flake path:${repos}/nix-dots/ $@
            fi
        }
        function x() {
            if [ -f "$1" ] ; then
                case "$1" in
                    *.tar.bz2) tar xjf    "$1" ;;
                    *.tar.gz)  tar xzf    "$1" ;;
                    *.bz2)     bunzip2    "$1" ;;
                    *.rar)     unrar x    "$1" ;;
                    *.gz)      gunzip     "$1" ;;
                    *.tar)     tar xf     "$1" ;;
                    *.tbz2)    tar xjf    "$1" ;;
                    *.tgz)     tar xzf    "$1" ;;
                    *.zip|*.xpi)     unzip      "$1" ;;
                    *.Z)       uncompress "$1" ;;
                    *.7z)      7z x       "$1" ;;
                    *)         echo "'$1' cannot be extracted via ex()" ;;
                esac
            else
                echo "'$1' is not a valid file"
            fi
        }
        '';

        initExtra = /* bash */ ''
        for plugin in $ZDOTDIR/plugins/pre/*.plugin.zsh; do
            source "$plugin"
        done

        for plugin in $ZDOTDIR/plugins/*.plugin.zsh; do
            zsh-defer source "$plugin"
        done

        # TTY colors
        if [ "$TERM" = "linux" ]; then
            echo -en "\e]P0${col.bg}" #black
            echo -en "\e]P8${col.t2}" #darkgrey
            echo -en "\e]P1${col.brown}" #darkred
            echo -en "\e]P9${col.red}" #red
            echo -en "\e]P2${col.green}" #darkgreen
            echo -en "\e]PA${col.green}" #green
            echo -en "\e]P3${col.orange}" #brown
            echo -en "\e]PB${col.yellow}" #yellow
            echo -en "\e]P4${col.blue}" #darkblue
            echo -en "\e]PC${col.blue}" #blue
            echo -en "\e]P5${col.purple}" #darkmagenta
            echo -en "\e]PD${col.purple}" #magenta
            echo -en "\e]P6${col.aqua}" #darkcyan
            echo -en "\e]PE${col.aqua}" #cyan
            echo -en "\e]P7${col.t4}" #lightgrey
            echo -en "\e]PF${col.fg}" #white
            clear #for background artifacting
        fi
        '';

        completionInit = /* bash */ ''
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
