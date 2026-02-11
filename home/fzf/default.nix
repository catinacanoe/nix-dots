{ lib, ... }:
let
    c = (import ../../rice).col;
in
{
    home.sessionVariables.FZF_DEFAULT_OPTS
        = lib.mkForce "--scrollbar=' ' --pointer='>' --gutter=' ' --color bg:-1,bg+:-1,fg:${c.fg.h},fg+:${c.aqua.h},gutter:-1,header:${c.red.h},hl:${c.aqua.h},hl+:${c.green.h},info:${c.mg.h},marker:${c.blue.h},pointer:${c.blue.h},preview-bg:-1,preview-fg:${c.fg.h},prompt:${c.mg.h},spinner:${c.red.h}";

    programs.fzf = {
        enable = true;
        # defaultOptions = [
        #     ''--scrollbar=" " --pointer=">" --gutter=" "''
        # ];
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
            # border = "-1";

            prompt = c.mg.h;
            pointer = c.blue.h;
            marker = c.blue.h;

            spinner = c.red.h;
            header = c.red.h;
        };
    };
}
