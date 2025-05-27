{ col, plugins, ... }:
let
    config = /* lua */ ''{
        "catppuccin/nvim",

        priority = 1000,

        config = function(_, _)
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
            })

            vim.o.background = "dark"
            vim.cmd("colorscheme catppuccin")

            vim.api.nvim_set_hl(0, "FloatShadow", {
                fg = "#${col.fg.hex}",
                bg = "#${col.bg.hex}",
            })
            vim.api.nvim_set_hl(0, "FloatShadowThrough", {
                fg = "#${col.fg.hex}",
                bg = "#${col.bg.hex}",
            })

            vim.api.nvim_set_hl(0, "NoiceLspProgressTitle", { fg = "#${col.fg.hex}" })
            vim.api.nvim_set_hl(0, "NoiceLspProgressClient", { fg = "#${col.purple.hex}" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#${col.fg.hex}" })
            vim.api.nvim_set_hl(0, "NoiceVirtualText", { fg = "#${col.mg.hex}" })
            vim.api.nvim_set_hl(0, "NoiceLspProgressSpinner", {
                fg = "#${col.fg.hex}",
                bg = "#${col.bg.hex}",
            })

            vim.api.nvim_set_hl(0, "MiniFilesBorder", { fg = "#${col.fg.hex}" })
            vim.api.nvim_set_hl(0, "MiniFilesTitle", { fg = "#${col.fg.hex}" })
            vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { fg = "#${col.red.hex}" })
            vim.api.nvim_set_hl(0, "MiniFilesFile", { fg = "#${col.aqua.hex}" })
            vim.api.nvim_set_hl(0, "MiniFilesCursorLine", {
                fg = "#${col.aqua.hex}",
                bg = "#${col.fg.hex}",
            })
        end
    }'';
in {
    plugin."${plugins}/catppuccin.lua".text = "return {${config}}";
}
