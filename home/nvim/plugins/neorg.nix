{ plugins, ... }:
let
    config = /* lua */ ''{
        "nvim-neorg/neorg",
        version = "v7.0.0", -- eventually i will update but i dont wanna update the config
        
        lazy = false,
        cmd = "Neorg",
        event = "BufEnter *.norg",

        init = function()
            vim.keymap.set("n", "<leader>ri", function()
                print("injecting metadata")
                vim.cmd "Neorg inject-metadata"
                vim.cmd("%s/^created: .*$/created: " .. os.date("%d.%m.%Y"))
                vim.cmd("%s/^updated: .*$/updated: " .. os.date("%d.%m.%Y"))
                vim.cmd("w!")
            end)

            vim.keymap.set("n", "<leader>rg", function()
                print("generating workspace summary")
                vim.cmd "Neorg generate-workspace-summary"
            end)

            -- change updated date string
            vim.api.nvim_create_autocmd({"BufRead"}, {
                pattern = { "*.norg" },
                callback = function(ev)

                    local target_folder = "/dox/wiki/"
                    local file_path = vim.fn.expand("<afile>:p")

                    if string.find(file_path, target_folder, 1, true) then
                        vim.cmd("%s/^updated: .*$/updated: " .. os.date("%d.%m.%Y"))
                    end
                end

            })
        end,

        opts = {
            load = {
                ['core.defaults'] = {},
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
                                icons = { "~", "~", "~", "~", "~", "~" },
                            },
                            heading = {
                                icons = { "*", "*", "*", "*", "*", "*" };
                            },
                            ordered = {
                                icons = { "1", "A", "a", "1", "A", "a" },
                            },
                        },
                    },
                },
                ['core.dirman'] = {
                    config = {
                        workspaces = {
                            main = '~/dox/wiki/',
                        },
                        default_workspace = 'main',
                        index = '.index.norg'
                    },
                },
                ['core.keybinds'] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.remap_key("norg", "i", "<M-CR>", "<S-CR>")
                            keybinds.map("norg", "i", "<C-CR>", " <BS><CR>")
                            keybinds.remap_key("norg", "n", ">>", "<c-t>")
                            keybinds.remap_key("norg", "n", "<<", "<c-d>")
                        end,
                    },
                },
                ['core.esupports.metagen'] = {
                    config = {
                        update_date = false,
                    },
                },
                ['core.summary'] = {},
                ['core.export'] = {},
                ['core.neorgcmd'] = {},
            }
        },

        dependencies = {
            -- "nvim-lua/plenary.nvim",
            "vhyrro/luarocks.nvim",
        },

    }'';
in {
    plugin."${plugins}/neorg.lua".text = "return {${config}}";
}
