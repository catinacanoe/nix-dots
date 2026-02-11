{ config, ... }@args: {
    programs.kitty.shellIntegration.enableZshIntegration = true;
    programs.starship.enableZshIntegration = true;
    programs.fzf.enableZshIntegration = true;
    services.gpg-agent.enableZshIntegration = true;

    # look through autosuggest strategies
    # look through syntax highlighting styles

    xdg.configFile."zsh/plugins" = {
        source = ./modules/plugin;
        recursive = true;
    };

    programs.zsh = {
        enable = true;
        dotDir = "${config.home.homeDirectory}/.config/zsh";

        enableCompletion = false;
        autosuggestion.enable = true;
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

        shellAliases = (import ./modules/alias/git.nix) //
                       (import ./modules/alias/other.nix) // {
            xioxide="source ${config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR}/xioxide/main.sh";
        };

        initContent = /*bash*/ ''
            ${import ./modules/function/xioxide.nix args}
            ${import ./modules/function/download.nix}
            ${import ./modules/function/extract.nix}

            ${builtins.readFile ./modules/bind/binds.zsh}
            ${builtins.readFile ./modules/bind/lazy-comp-init.zsh}

            source $ZDOTDIR/plugins/nix-shell.plugin.zsh
        '';

        # comp options in case i need to revert some

        # completionInit = /* bash */ ''
        # autoload -U compinit
        # zstyle ':completion:*' menu select
        # zmodload zsh/complist
        # compinit
        # _comp_options+=(globdots)
        # '';
    };
}
