{ ... }:
let
    c = (import ../../rice).col;
in
{
    programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        colors = {
            fg = c.fg.h;
            "fg+" = c.aqua.h;

            bg = "-1";
            "bg+" = "-1";

            preview-fg = c.fg.h;
            preview-bg = "-1";

            hl = c.aqua.h;
            "hl+" = c.green.h;

            gutter = "-1";
            info = c.mg.h;
            # border = c.mg.h;
            border = "-1";

            prompt = c.mg.h;
            pointer = c.blue.h;
            marker = c.blue.h;

            spinner = c.red.h;
            header = c.red.h;
        };
    };
}
