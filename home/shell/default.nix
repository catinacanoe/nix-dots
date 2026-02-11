{ config, lib, ... }@args:
let
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
  
in
{
    programs.zsh = {
        enable = true;
        dotDir = "${config.home.homeDirectory}/.config/zsh";

        # enableCompletion = true;
        # enableAutosuggestions = true;
        # autosuggestion.enable = true;
        # syntaxHighlighting.enable = true;

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

        shellAliases = (import ./modules/aliases-git.nix) //
                       (import ./modules/aliases-other.nix);

        initContent = /*bash*/''
            ${import ./modules/functions-xioxide.nix args}
            ${import ./modules/functions-download.nix}
            ${import ./modules/functions-extract.nix}

            # for plugin in $ZDOTDIR/plugins/pre/*.plugin.zsh; do
            #     source "$plugin"
            # done

            # for plugin in $ZDOTDIR/plugins/*.plugin.zsh; do
            #     zsh-defer source "$plugin"
            # done
        '';

        # completionInit = /* bash */ ''
        # autoload -U compinit
        # zstyle ':completion:*' menu select
        # zmodload zsh/complist
        # compinit
        # _comp_options+=(globdots)

        # bindkey -e

        # function copy_buffer() { wl-copy -n <<< "$BUFFER"; }
        # zle -N copy_buffer
        # bindkey "^Y" copy_buffer

        # bindkey "^[[1;2D" beginning-of-line # shift left
        # bindkey "^[[1;2C" end-of-line # shift left

        # bindkey "^[[3~" delete-char # delete key

        # bindkey '^[[Z' autosuggest-accept # shift tab
        # bindkey '^I' expand-or-complete # tab
        # '';
    };
}
