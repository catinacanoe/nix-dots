{ plugins, ... }:
let
    config = /* lua */ ''{
        "andrewferrier/wrapping.nvim",

        lazy = false,

        opts = {
            auto_set_mode_filetype_allowlist = {
                "norg",
                "asciidoc",
                "gitcommit",
                "latex",
                "mail",
                "markdown",
                "rst",
                "tex",
                "text",
            },
            softener = {
                norg = true,
            },
        },
    }'';
in {
    plugin."${plugins}/wrapping.lua".text = "return {${config}}";
}
