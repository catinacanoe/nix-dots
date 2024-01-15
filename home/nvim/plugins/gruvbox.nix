{ col, plugins, ... }:
let
    config = /* lua */ ''{
        "ellisonleao/gruvbox.nvim",

        priority = 1000,

        config = function(_, _)
            require("gruvbox").setup({
                italic = {
                    operators = true,
                },
                transparent_mode = true,
                palette_overrides = {
                    dark0 = "#${col.bg.hex}",
                    dark0_hard = "#${col.bg.hex}",
                    dark0_soft = "#${col.bg.hex}",
                    dark1 = "#${col.t1.hex}",
                    dark2 = "#${col.t2.hex}",
                    dark3 = "#${col.t3.hex}",
                    dark4 = "#${col.t3.hex}",
                    light4 = "#${col.t4.hex}",
                    light3 = "#${col.t4.hex}",
                    light2 = "#${col.t5.hex}",
                    light1 = "#${col.t6.hex}",
                    light0 = "#${col.fg.hex}",
                    light0_hard = "#${col.fg.hex}",
                    light0_soft = "#${col.fg.hex}",
                    gray = "#${col.mg.hex}",

                    light_red_hard = "#${col.red.hex}",
                    light_red = "#${col.red.hex}",
                    light_red_soft = "#${col.red.hex}",
                    bright_red = "#${col.red.hex}",
                    neutral_red = "#${col.red.hex}",
                    faded_red = "#${col.red.hex}",

                    bright_yellow = "#${col.yellow.hex}",
                    neutral_yellow = "#${col.yellow.hex}",
                    faded_yellow = "#${col.yellow.hex}",

                    bright_orange = "#${col.orange.hex}",
                    neutral_orange = "#${col.orange.hex}",
                    faded_orange = "#${col.orange.hex}",

                    dark_green_hard = "#${col.green.hex}",
                    dark_green = "#${col.green.hex}",
                    dark_green_soft = "#${col.green.hex}",
                    light_green_hard = "#${col.green.hex}",
                    light_green = "#${col.green.hex}",
                    light_green_soft = "#${col.green.hex}",
                    bright_green = "#${col.green.hex}",
                    neutral_green = "#${col.green.hex}",
                    faded_green = "#${col.green.hex}",

                    dark_aqua_hard = "#${col.aqua.hex}",
                    dark_aqua = "#${col.aqua.hex}",
                    dark_aqua_soft = "#${col.aqua.hex}",
                    light_aqua_hard = "#${col.aqua.hex}",
                    light_aqua = "#${col.aqua.hex}",
                    light_aqua_soft = "#${col.aqua.hex}",
                    bright_aqua = "#${col.aqua.hex}",
                    neutral_aqua = "#${col.aqua.hex}",
                    faded_aqua = "#${col.aqua.hex}",

                    bright_blue = "#${col.blue.hex}",
                    neutral_blue = "#${col.blue.hex}",
                    faded_blue = "#${col.blue.hex}",

                    bright_purple = "#${col.purple.hex}",
                    neutral_purple = "#${col.purple.hex}",
                    faded_purple = "#${col.purple.hex}",

                    dark_red_hard = "#${col.brown.hex}",
                    dark_red = "#${col.brown.hex}",
                    dark_red_soft = "#${col.brown.hex}",
                },
            })

            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox")

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
    plugin."${plugins}/gruvbox.lua".text = "return {${config}}";
}
