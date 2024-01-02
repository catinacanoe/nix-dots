{ col, pkgs, ... }:
{
    plugin = pkgs.vimPlugins.lualine-nvim;
    type = "lua";
    config = /* lua */ ''
        vim.o.showmode = false; -- remove the ' -- INSERT -- ' line at the bottom

        require('lualine').setup {
            options = {
                icons_enabled = false,
                component_separators = { left = '|', right = '|'},
                section_separators = { left = "", right = ""},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
                theme = {
                    normal = {
                      a = {bg = "#${col.t4}", fg = "#${col.bg}", gui = 'bold'},
                      b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                      c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'}
                    },
                    insert = {
                      a = {bg = "#${col.blue}", fg = "#${col.bg}", gui = 'bold'},
                      b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                      c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'}
                    },
                    visual = {
                      a = {bg = "#${col.purple}", fg = "#${col.bg}", gui = 'bold'},
                      b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                      c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'}
                    },
                    replace = {
                      a = {bg = "#${col.red}", fg = "#${col.bg}", gui = 'bold'},
                      b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                      c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'}
                    },
                    command = {
                      a = {bg = "#${col.aqua}", fg = "#${col.bg}", gui = 'bold'},
                      b = {bg = "#${col.t2}", fg = "#${col.fg}"},
                      c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'}
                    },
                    inactive = {
                      a = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'bold'},
                      b = {bg = "#${col.t1}", fg = "#${col.fg}"},
                      c = {bg = "#${col.t1}", fg = "#${col.t4}", gui = 'italic'}
                    }
		},
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {"os.date('%H:%M')"},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    '';
}
