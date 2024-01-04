{ plugins, col, ... }:
let
    config = /* lua */ ''
        "folke/noice.nvim",
        
        config = function(_, _)
            vim.cmd("hi FloatShadow guibg=#${col.bg}")
            vim.cmd("hi FloatShadow guifg=#${col.fg}")
            vim.cmd("hi FloatShadowThrough guibg=#${col.bg}")
            vim.cmd("hi FloatShadowThrough guifg=#${col.fg}")

            vim.cmd("hi NoiceLspProgressSpinner guibg=#${col.bg}")
            vim.cmd("hi NoiceLspProgressSpinner guifg=#${col.bg}")
            vim.cmd("hi NoiceLspProgressTitle guifg=#${col.fg}")
            vim.cmd("hi NoiceLspProgressClient guifg=#${col.purple}")

            vim.cmd("hi NoiceVirtualText guifg=#${col.mg}")
            vim.cmd("hi NoiceCmdlinePopupBorder guifg=#${col.fg}")

            require("notify").setup {
                background_colour = "#${col.bg}",
                fps = 60,
                top_down = false,
                timeout = 3000,
                render = "minimal",
                stages = "slide",
                icons = {
                    DEBUG = "B",
                    ERROR = "E",
                    INFO = "I",
                    TRACE = "T",
                    WARN = "W",
                },
            }

            require("noice").setup {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    progress = {
                        view = "notify",
                        throttle = 1000,
                    },
                    hover = { enabled = false },
                    signature = { enabled = false },
                    documentation = { enabled = false },
                    routes = {
                        {
                            view = "notify",
                            filter = { event = "msg_showmode" },
                        },
                        {
                            filter = {
                                event = "msg_show",
                                kind = "",
                                find = "written",
                            },
                            opts = { skip = true },
                        },
                        { -- hide AutoSave notifs
                            filter = {
                                event = "msg_show",
                                kind = "",
                                find = "AutoSave:",
                            },
                            opts = { skip = true },
                        },
                    },
                },

                cmdline = {
                    enabled = true,
                    view = "cmdline_popup",
                    format = {
                        cmdline = { icon = ">" },
                        search_down = { icon = "/" },
                        search_up = { icon = "\\" },
                        filter = { icon = "$" },
                        lua = { icon = "%" },
                        help = { icon = "?" },
                    },
                },

                format = { level = { icons = {
                    error = "E",
                    warn = "W",
                    info = "I",
                }}},

                inc_rename = { cmdline = { format = { IncRename = {
                    icon = "R",
                }}}},

                popupmenu = { kind_icons = false },

                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            }
        end,

        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    '';
in {
    plugin."${plugins}/noice.lua".text = ''
        return {{
            ${config}
        }}
    '';
}
