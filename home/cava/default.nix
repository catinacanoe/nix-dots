{ ... }: {
    programs.cava = {
        enable = true;
        settings = {
            general = {
                framerate = 60;
                autosens = 1;
                bars = 0;
                bar_width = 2;
                bar_spacing = 1;
                lower_cutoff_freq = 35;
                higher_cutoff_freq = 10000;
            };

            output = {
                method = "ncurses";
                orientation = "bottom";
                channels = "mono";
                mono_option = "average";
            };
        };
    };
}
