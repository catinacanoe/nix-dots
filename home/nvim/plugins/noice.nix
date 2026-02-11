{ plugins, col, rice, ... }:
let
    config = /* lua */ ''
        "folke/noice.nvim",

        keys = {
            { "<leader><leader>", "<cmd>NoiceDismiss<cr>" },
        },
        
        config = function(_, _)
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
                            filter = {
                                event = "msg_showmode",
                            },
                            view = "notify",
                        },
                        {
                            filter = {
                                event = "notify",
                                find = "No information available",
                            },
                            opts = { skip = true },
                        },
                        {
                            filter = {
                                event = "notify",
                                find = "written",
                            },
                            opts = { skip = true },
                        },
                        { -- hide AutoSave notifs
                            filter = {
                                event = "notify",
                                find = "AutoSave:",
                            },
                            opts = { skip = true },
                        },
                    },
                },

                routes = {{
                    filter = { find = "Loading NixOS", },
                    opts = { skip = true },
                },{
                    filter = { find = "Config Change Detected", },
                    opts = { skip = true },
                },{
                    filter = { find = "more lines", },
                    opts = { skip = true },
                },{
                    filter = { find = "lines yanked", },
                    opts = { skip = true },
                },{
                    filter = { find = "<ed", },
                    opts = { skip = true },
                },{
                    filter = { find = ">ed", },
                    opts = { skip = true },
                },},

                views = {
                    cmdline_popup = { border = {
                        style = "${if rice.style.rounding then "rounded" else "single"}",
                    },},
                },

                commands = {
                    history = { view = "split" },
                    last = { view = "split" },
                    errors = { view = "split" },
                },

                cmdline = {
                    enabled = true,
                    view = "cmdline_popup",
                    format = {
                        cmdline = { icon = ">" },
                        search_down = { icon = " /" },
                        search_up = { icon = " \\" },
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

            require("notify").setup {
                background_colour = "${col.bg.h}",
                fps = 10,
                top_down = false,
                timeout = 5000,
                render = "minimal",
                stages = "${if rice.style.animation then "slide" else "static"}",
                icons = {
                    DEBUG = "B",
                    ERROR = "E",
                    INFO = "I",
                    TRACE = "T",
                    WARN = "W",
                },
                on_open = function(win)
                    local config = vim.api.nvim_win_get_config(win)
                    config.border = "${if rice.style.rounding then "rounded" else "single"}"
                    vim.api.nvim_win_set_config(win, config)

                    vim.cmd("syntax off")
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.api.nvim_buf_set_option(buf, "filetype", "txt")

                    vim.api.nvim_set_hl(0, "NotifyERRORBorder", {fg="${col.red.h}"})
                    vim.api.nvim_set_hl(0,  "NotifyWARNBorder", {fg="${col.orange.h}"})
                    vim.api.nvim_set_hl(0,  "NotifyINFOBorder", {fg="${col.green.h}"})
                    vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", {fg="${col.blue.h}"})
                    vim.api.nvim_set_hl(0, "NotifyTRACEBorder", {fg="${col.purple.h}"})

                    vim.api.nvim_set_hl(0, "NotifyERRORTitle",  {fg="${col.red.h}"})
                    vim.api.nvim_set_hl(0,  "NotifyWARNTitle",  {fg="${col.orange.h}"})
                    vim.api.nvim_set_hl(0,  "NotifyINFOTitle",  {fg="${col.green.h}"})
                    vim.api.nvim_set_hl(0, "NotifyDEBUGTitle",  {fg="${col.blue.h}"})
                    vim.api.nvim_set_hl(0, "NotifyTRACETitle",  {fg="${col.purple.h}"})

                    vim.api.nvim_set_hl(0, "NotifyERRORBody",   {fg="${col.red.h}"})
                    vim.api.nvim_set_hl(0,  "NotifyWARNBody",   {fg="${col.orange.h}"})
                    vim.api.nvim_set_hl(0,  "NotifyINFOBody",   {fg="${col.green.h}"})
                    vim.api.nvim_set_hl(0, "NotifyDEBUGBody",   {fg="${col.blue.h}"})
                    vim.api.nvim_set_hl(0, "NotifyTRACEBody",   {fg="${col.purple.h}"})
                end,
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
