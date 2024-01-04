{ plugins, ... }:
let
    config = /* lua */ ''{
        "nvim-telescope/telescope.nvim",

        lazy = true,
        keys = {
            { "<leader>st", function() require('telescope.builtin').git_files() end },
            { "<leader>sf", function() require('telescope.builtin').find_files() end },
            { "<leader>sg", function() require('telescope.builtin').live_grep() end },
            { "<leader>sh", function() require('telescope.builtin').buffers() end },

            { "gr", function() require('telescope.builtin').lsp_references() end },
            { "<leader>sd", function() require('telescope.builtin').lsp_document_symbols() end },
            { "<leader>sd", function() require('telescope.builtin').lsp_workspace_symbols() end },
        },

        config = function(_, _)
            require('telescope').setup {
                defaults = { mappings = { i = {
                    [";n"] = require('telescope.actions').close,
                }}},

                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {},
                    },
                },
            }

            require('telescope').load_extension("ui-select")
        end,
        
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            -- telescope-neorg
            -- telescope-sg
        },
    }'';
in
{
    plugin."${plugins}/telescope.lua".text = "return {${config}}";
}
