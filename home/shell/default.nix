{ config, ... }@args:
let
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
            hst = "tac $ZDOTDIR/.zsh_history | awk -F ';' '{ print $2 }' | fzf | tr -d '\\n' | wtype -";

            tp = "gotop";

            o = "e ../";
            oo = "e ../..";
            ooo = "e ../../..";
            oooo = "e ../../../..";
            ooooo = "e ../../../../..";
            oooooo = "e ../../../../../..";

            k = "mkdir -p";
            l = "touch";
            m = "mv -i";
            y = "cp -ri";
            c = "chmod";
            r = "trash-put";
            z = "exit";

            src = "exec zsh";

            t = "eza -Ta";
            n = "eza -a1lo --no-user --no-permissions --no-filesize --no-time";

            gp = "grep";
            gpi = "grep -i";

            q = "qalc";

            nt = "~/dox/norgtask/bin/asan";

            ns = "nix-shell";
        };

        initExtraFirst = let
            xioxide_fn = ''[ "$1" == "$HOME" ] && return || return 1'';
        in
        with config.programs.zsh.shellAliases; /* bash */ ''
        e() { ${xioxide} cd "grep '/$'" pwd '${xioxide_fn}' dirs $@ && ${n}; }
        eo() { cd - > /dev/null && ${n}; }
        ke() { ${k} "$1" && e "$1"; }

        a() { ${xioxide} lf "grep '/$'" pwd '${xioxide_fn}' dirs $@; }
        sy() {
            ${xioxide} "" "" pwd '${xioxide_fn}' dirs $@ | read file
            tmp=$(mktemp) && cp "$file" "$tmp" && echo "rm $tmp" | at now + 2 min && sioyek "$tmp"
        }
        A() { ${xioxide} lfcd "grep '/$'" pwd '${xioxide_fn}' dirs $@; }
        h() { [ -z "$1" ] && "$EDITOR" . || ${xioxide} "$EDITOR" "" pwd '${xioxide_fn}' dirs $@; }

        dsf() { diff -u $@  | diff-so-fancy | less --tabs=4 -RF; }
        function x() {
            if [ -f "$1" ] ; then
                case "$1" in
                    *.tar.bz2) tar xjf    "$1" ;;
                    *.tar.gz)  tar xzf    "$1" ;;
                    *.tar.xz)  unxz       "$1" ;;
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
        function vdl() {
            if [ -n "$1" ]; then
                yt-dlp --format mp4 "$@"
            else
                yt-dlp --format mp4 "$(wl-paste)"
            fi
        }
        function adl() {
            if [ -n "$1" ]; then
                yt-dlp -x --audio-format mp3 --audio-quality 0 "$@"
            else
                yt-dlp -x --audio-format mp3 --audio-quality 0 "$(wl-paste)"
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
            echo -en "\e]P0${col.bg.hex}" #black
            echo -en "\e]P8${col.t2.hex}" #darkgrey
            echo -en "\e]P1${col.brown.hex}" #darkred
            echo -en "\e]P9${col.red.hex}" #red
            echo -en "\e]P2${col.green.hex}" #darkgreen
            echo -en "\e]PA${col.green.hex}" #green
            echo -en "\e]P3${col.orange.hex}" #brown
            echo -en "\e]PB${col.yellow.hex}" #yellow
            echo -en "\e]P4${col.blue.hex}" #darkblue
            echo -en "\e]PC${col.blue.hex}" #blue
            echo -en "\e]P5${col.purple.hex}" #darkmagenta
            echo -en "\e]PD${col.purple.hex}" #magenta
            echo -en "\e]P6${col.aqua.hex}" #darkcyan
            echo -en "\e]PE${col.aqua.hex}" #cyan
            echo -en "\e]P7${col.t4.hex}" #lightgrey
            echo -en "\e]PF${col.fg.hex}" #white
            clear #for background artifacting
        fi
        '';

        completionInit = /* bash */ ''
        autoload -U compinit
        zstyle ':completion:*' menu select
        zmodload zsh/complist
        compinit
        _comp_options+=(globdots)

        bindkey -e

        function copy_buffer() { wl-copy -n <<< "$BUFFER"; }
        zle -N copy_buffer
        bindkey "^Y" copy_buffer

        bindkey "^[[1;2D" beginning-of-line # shift left
        bindkey "^[[1;2C" end-of-line # shift left

        bindkey "^[[3~" delete-char # delete key

        bindkey '^[[Z' autosuggest-accept # shift tab
        bindkey '^I' expand-or-complete # tab
        '';
    };
}
