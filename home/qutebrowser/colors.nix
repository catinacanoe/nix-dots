with (import ../../rice).col; {
    webpage = {
        preferred_color_scheme = "dark";
        darkmode = {
            enabled = true;
        };
    };

    tooltip = { fg=fg.h; bg=bg.h; };
    hints = {
        fg = fg.h;
        bg = "rgba(${bg.rgb}, 0.8)";
        match.fg = blue.h;
    };

    messages = {
        error = {
            fg = red.h;
            bg = bg.h;
            border = "#00000000";
        };
        warning = {
            fg = yellow.h;
            bg = bg.h;
            border = "#00000000";
        };
        info = {
            fg = fg.h;
            bg = bg.h;
            border = "#00000000";
        };
    };

    prompts = {
        fg = fg.h;
        bg = t1.h;
        border = "#00000000";
        selected = {
            fg = blue.h;
            bg = t1.h;
        };
    };

    downloads = {
        bar.bg = bg.h;
        error = { fg=red.h; bg=bg.h; };
        start = { fg=fg.h; bg=bg.h; };
        stop = { fg=bg.h; bg=blue.h; };
        system = { fg="none"; bg="none"; };
    };

    tabs = {
        bar.bg = bg.h;
        even = { fg = fg.h; bg = bg.h; };
        odd  = { fg = fg.h; bg = bg.h; };
        selected = {
            even = { fg = fg.h; bg = t1.h; };
            odd  = { fg = fg.h; bg = t1.h; };
        };
    };

    completion = {
        category = { fg=blue.h; bg=t1.h; border.bottom=t1.h; border.top=t1.h; };
        even.bg = bg.h;
        odd.bg = bg.h;

        fg = fg.h;
        match.fg = blue.h;

        item.selected = {
            bg = t1.h;
            border.bottom = t1.h;
            border.top = t1.h;
            fg = fg.h;
            match.fg = blue.h;
        };
    };

    statusbar = {
        progress.bg = fg.h;
        caret = {
            fg = bg.h;
            bg = purple.h;
            selection = {
                fg = bg.h;
                bg = purple.h;
            };
        };
        normal =  { fg = fg.h; bg = bg.h; };
        command = { fg = fg.h; bg = bg.h; };
        insert =  { fg = bg.h; bg = blue.h; };
        url = {
            fg               = mg.h;
            error.fg         = red.h;
            warn.fg          = yellow.h;
            hover.fg         = mg.h;
            success.http.fg  = fg.h;
            success.https.fg = fg.h;
        };
    };
}
