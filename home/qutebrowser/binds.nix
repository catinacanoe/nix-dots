{ config, ... }: {
    normal = {
        "." = "cmd-repeat-last";
        ":" = "cmd-set-text :";
        "/" = "cmd-set-text /";

        "<esc>" = "clear-keychain ;; search ;; fullscreen --leave";

        N = "back";
        A = "tab-prev";
        I = "tab-next";
        O = "forward";
        ga = "tab-focus 1";
        gi = "tab-focus -1";

        n = "scroll left";
        a = "scroll up";
        i = "scroll down";
        o = "scroll right";
        gg = "scroll-to-perc 0";
        G = "scroll-to-perc";

        "<up>" = "tab-move -";
        "<down>" = "tab-move +";

        l = "cmd-set-text -s :open";
        L = "cmd-set-text -s :open -t";
        "<ctrl-l>" = "spawn drop browseshell nohistory";
        "<ctrl-h>" = "history -t";
        j = "search-next";
        J = "search-prev";

        V = "config-cycle colors.webpage.darkmode.enabled";
        h = "mode-enter insert";
        m = "tab-mute";
        z = "tab-close";
        u = "undo";
        q = "tab-detach";
        r = "reload";
        R = "yank ;; tab-close";
        "<ctrl-r>" = "greasemonkey-reload ;; reload";
        f = "fullscreen";
        "<space>" = "config-cycle tabs.show always never"; # ;; config-cycle statusbar.show always in-mode"; # cycle tabs open close
        "<ctrl-space>" = "clear-messages ;; download-clear";
        "+" = "zoom-in";
        "-" = "zoom-out";
        "=" = "zoom";

        y = "yank";
        p = "open -- {clipboard}";
        P = "open -t -- {clipboard}";

        "<tab>" = "hint";

        d = "devtools";

        # USERSCRIPTS
        v = "spawn ${config.home.sessionVariables.TERMINAL} mpv --input-ipc-server=~/.config/mpvc/mpvsocket0 '{url}'"; # open current yt vid in mpv
        t = "spawn --userscript translate.sh";

        # WARN: we pre-call 'drop menu' here for optimization,
        # so in the script we have to pass --menuui-is-open to menu
        w = "spawn drop menu nohistory ;; spawn --userscript browseshell.sh";
    };

    insert = {
        ";n" = "mode-leave";
        ";;" = "fake-key ;";
    };

    command = {
        "<esc>" = "mode-leave";
        "<return>" = "command-accept";

        "<up>" = "completion-item-focus --history prev";
        "<down>" = "completion-item-focus --history next";
    };

    hint = {
        ";n" = "mode-leave";
        "<tab>" = "hint all tab-bg";
        "<return>" = "hint-follow";
        p = "spawn --userscript pass.sh";
        P = "spawn --userscript pass.sh --interactive";
    };

    yesno = {
        y = "prompt-accept yes";
        n = "prompt-accept no";
        Y = "prompt-accept --save yes";
        N = "prompt-accept --save no";
        "<esc>" = "mode-leave";
        "<return>" = "prompt-accept";
    };

    prompt = {
        "<esc>" = "mode-leave";
        "<return>" = "prompt-accept";
    };
}
