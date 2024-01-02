{ col, pkgs, ... }:
{
    plugin = pkgs.vimPlugins.indent-blankline-nvim;
    type = "lua";
    config = /* lua */ ''
        local highlight = {
            "indent_gray",
            "indent_dark_gray",
        }

        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "indent_purple", { fg = "#${col.purple}" })
            vim.api.nvim_set_hl(0, "indent_gray", { fg = "#${col.t3}" })
            vim.api.nvim_set_hl(0, "indent_dark_gray", { fg = "#${col.t2}" })
        end)

        -- charlist: ▎ ▏ ║ ╎ ╏ ┆ ┇ ┊ ┋
        require("ibl").setup {
            indent = { highlight = highlight, char = "▏"},
            whitespace = { highlight = highlight, remove_blankline_trail = false},
            scope = { char = "▎", enabled = true , highlight = "indent_purple", show_start = false },
        }
    '';
}
