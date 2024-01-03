{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.trouble-nvim;
    type = "lua";
    config = /* lua */ ''
        require("trouble").setup {
            icons = false,
            fold_open = "v",
            fold_closed = ">",
            indent_lines = false,
            use_diagnostic_signs = true
        }

        vim.keymap.set("n", "<leader>ex", "<cmd>TroubleToggle workspace_diagnostics<cr>")
    '';
}
