{ pkgs, ... }:
with pkgs.vimPlugins;
{
    plugin = {
        plugin = telescope-nvim;
        type = "lua";
        config = /* lua */ ''
            local tele_builtin = require('telescope.builtin')
            local tele_actions = require('telescope.actions')
            
            vim.keymap.set('n', '<leader>st', tele_builtin.git_files)
            vim.keymap.set('n', '<leader>sf', tele_builtin.find_files)
            vim.keymap.set('n', '<leader>sg', tele_builtin.live_grep)
            vim.keymap.set('n', '<leader>sb', tele_builtin.buffers)
            
            vim.keymap.set('n', 'gr', tele_builtin.lsp_references)
            vim.keymap.set('n', '<leader>sd', tele_builtin.lsp_document_symbols)
            vim.keymap.set('n', '<leader>sw', tele_builtin.lsp_workspace_symbols)
            
            require('telescope').setup {
                defaults = { mappings = { i = {
                    [";n"] = tele_actions.close,
                }}},
    
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {},
                    },
                },
            }
    
            require('telescope').load_extension("ui-select")
        '';
    };

    plugins = [
        telescope-ui-select-nvim
        # telescope-neorg
        # telescope-sg
    ];
}
