{ plugins, ... }:
let
    config = /* lua */ ''{
        "nvim-neorg/neorg",
        
        lazy = false,
        cmd = "Neorg",
        event = "BufEnter *.norg",

        keys = {
            { '<leader>ri', '<cmd>Neorg inject-metadata<cr>' },
            { '<leader>rg', '<cmd>Neorg generate-workspace-summary<cr>' },
        },

        opts = {
            load = {
                ['core.defaults'] = {},
                ['core.presenter'] = {
                    config = {
                        zen_mode = "truezen"
                    }
                },
                ['core.concealer'] = {
                    config = {
                        icons = {
                            code_block = {
                                content_only = false,
                                width = "content",
                                padding = {
                                    left = 0,
                                    right = 5,
                                },
                            },
                            list = {
                                icons = { "~", "-", "+", "~", "-", "+", },
                            },
                            heading = {
                                icons = { "*", "*", "*", "*", "*", "*", },
                            },
                        },
                    },
                },
                ['core.dirman'] = {
                    config = {
                        workspaces = {
                            main = '~/crypt/wiki/',
                        },
                        default_workspace = 'main',
                        index = '.index.norg'
                    },
                },
                ['core.keybinds'] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.remap_key("norg", "i", "<M-CR>", "<C-CR>")
                        end,
                    },
                },
                ['core.summary'] = {},
                ['core.neorgcmd'] = {},
            }
        },

        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    }'';
in {
    plugin."${plugins}/neorg.lua".text = "return {${config}}";
}
