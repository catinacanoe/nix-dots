{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.treesj;
    type = "lua";
    config = /* lua */ ''
        require("treesj").setup {
            use_default_keymaps = false,
        }
        vim.keymap.set("n", "<leader>et", vim.cmd.TSJToggle)
    '';
}
