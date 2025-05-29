{
    settings = { # same tree as running ':set' from inside qb
        new_instance_open_target = "tab-bg-silent"; # prevents config-source from raising focus, see https://l.opnxng.com/r/qutebrowser/comments/mavj50/how_to_configsource_from_terminal_without_raising/
        messages.timeout = 1000;
        fonts.default_size = "11pt";

        hints = {
            border = "none";
            chars = "rsthnaio";
        };

        completion = {
            height = "30%";
            scrollbar = {padding=0; width=0;};
            shrink = true;
        };

        downloads = {
            remove_finished = 3000;
        };

        tabs = {
            position = "left";
            width = 200;
            indicator.width = 0;
            last_close = "close";
            show = "always";
            title = {
                elide = "none";
                format = "{audio}{current_title}";
            };
        };

        statusbar = {
            position = "bottom";
            show = "always";
        };

        url = {
            default_page = "about:blank";
            start_pages = "catppuccin.com";
        };

        content.pdfjs = true; # view pdf files in browser
    };

    extraConfig = /* py */ ''
        n = 4
        c.tabs.padding = {'bottom': n, 'top': n, 'left': n, 'right': n}

        c.statusbar.widgets = ['keypress', 'search_match', 'url', 'progress']
    '';
}

