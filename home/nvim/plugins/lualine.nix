{ col, plugins, ... }:
let
    sections = /* lua */ ''
        winbar = {
            lualine_a = {{
                "tabs",
                mode = 0,
                path = 0,
                use_mode_colors = true,
                show_modified_status = false,
            }},
            lualine_c = {{
                "filename",
                symbols = {
                    modified = "",
                    readonly = "RO",
                    unnamed = "unnamed",
                    newfile = "new",
                }
            }},
            lualine_x = {"location", "diagnostics", "diff"},
            lualine_y = {},
            lualine_z = {"branch"}
        },

        sections = {
            lualine_a = {{
                "buffers",
                max_length = vim.o.columns,
                show_modified_status = false,
                use_mode_colors = true,
                symbols = {
                    modified = "",
                    alternate_file = "",
                    directory = "",
                },
            }},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {
                {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    color = { fg = "#${col.purple.hex}" },
                }
            },
            lualine_y = {},
            lualine_z = {"os.date('%H:%M')"},
        },

        inactive_winbar = {
            lualine_c = {"filename"},
        },
    '';
in
let
    config = /* lua */ ''{
        "nvim-lualine/lualine.nvim",

        config = function(_, _)
            require('lualine').setup {

                ${sections}

                tabline = {},
                inactive_sections = {},
                
                options = {
                    globalstatus = true,
                    icons_enabled = false,
                    component_separators = " ",
                    section_separators = "",
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = false,
                    refresh = {
                        statusline = 300,
                        tabline = 700,
                    },

                    -- theme = 'solarized_light', -- just uncomment this, reload config and then lualine will properly reprocess new custom theme after that
                    theme = {
                        normal = {
                          a = {bg = "#${col.t5.hex}", fg = "#${col.bg.hex}", gui = 'bold'},
                          b = {bg = "#${col.t2.hex}", fg = "#${col.fg.hex}"},
                          c = {bg = "#${col.t1.hex}", fg = "#${col.t5.hex}", gui = 'italic'},
                        },
                        insert = {
                          a = {bg = "#${col.blue.hex}", fg = "#${col.bg.hex}", gui = 'bold'},
                          b = {bg = "#${col.t2.hex}", fg = "#${col.fg.hex}"},
                          c = {bg = "#${col.t1.hex}", fg = "#${col.t5.hex}", gui = 'italic'},
                        },
                        visual = {
                          a = {bg = "#${col.purple.hex}", fg = "#${col.bg.hex}", gui = 'bold'},
                          b = {bg = "#${col.t2.hex}", fg = "#${col.fg.hex}"},
                          c = {bg = "#${col.t1.hex}", fg = "#${col.t5.hex}", gui = 'italic'},
                        },
                        replace = {
                          a = {bg = "#${col.red.hex}", fg = "#${col.bg.hex}", gui = 'bold'},
                          b = {bg = "#${col.t2.hex}", fg = "#${col.fg.hex}"},
                          c = {bg = "#${col.t1.hex}", fg = "#${col.t5.hex}", gui = 'italic'},
                        },
                        command = {
                          a = {bg = "#${col.aqua.hex}", fg = "#${col.bg.hex}", gui = 'bold'},
                          b = {bg = "#${col.t2.hex}", fg = "#${col.fg.hex}"},
                          c = {bg = "#${col.t1.hex}", fg = "#${col.t5.hex}", gui = 'italic'},
                        },
                        inactive = {
                          a = {bg = "#${col.t1.hex}", fg = "#${col.t5.hex}", gui = 'bold'},
                          b = {bg = "#${col.t1.hex}", fg = "#${col.fg.hex}"},
                          c = {bg = "#${col.t1.hex}", fg = "#${col.t5.hex}", gui = 'italic'},
                        },
                    }
                }
            }
        end
    }'';
in {
    plugin."${plugins}/lualine.lua".text = "return {${config}}";
    inherit sections;
}
