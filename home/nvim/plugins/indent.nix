{ col, plugins, ... }:
let
    config = /* lua */ ''{
        "lukas-reineke/indent-blankline.nvim",

        lazy = true,
        event = "VeryLazy",

        setup = function()
            vim.g.indent_blankline_filetype_exclude = {"norg"}
        end,

        config = function()
            local highlight = {
                "indent_1",
                "indent_2",
            }

            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "indent_1", { fg = "${col.t3.h}" })
                vim.api.nvim_set_hl(0, "indent_2", { fg = "${col.t4.h}" })
            end)

            -- charlist: ▎ ▏ ║ ╎ ╏ ┆ ┇ ┊ ┋
            require("ibl").setup {
                indent = {
                    highlight = highlight,
                    char = "┊",
                },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false,
                },
                scope = {
                    enabled = false,
                },
                exclude = {
                    filetypes = { "norg" },
                    buftypes = { "terminal" },
                },
            }
        end,
    }'';
in {
    plugin."${plugins}/indent.lua".text= "return {${config}}";
}
