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
                    color = { fg = "#${col.purple}" },
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

                    theme = {
                        normal = {
                          a = {bg = "#${col.t4}", fg = "#${col.bg}", gui = 'bold'},
                          b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                          c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'},
                        },
                        insert = {
                          a = {bg = "#${col.blue}", fg = "#${col.bg}", gui = 'bold'},
                          b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                          c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'},
                        },
                        visual = {
                          a = {bg = "#${col.purple}", fg = "#${col.bg}", gui = 'bold'},
                          b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                          c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'},
                        },
                        replace = {
                          a = {bg = "#${col.red}", fg = "#${col.bg}", gui = 'bold'},
                          b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                          c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'},
                        },
                        command = {
                          a = {bg = "#${col.aqua}", fg = "#${col.bg}", gui = 'bold'},
                          b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                          c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'},
                        },
                        inactive = {
                          a = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'bold'},
                          b = {bg = "#${col.t1}", fg = "#${col.fg}"},
                          c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'},
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
