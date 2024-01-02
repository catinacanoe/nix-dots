{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.undotree;
    type = "lua";
    config = /* lua */ ''
        vim.keymap.set("n", "<leader>u", ':UndotreeToggle<CR><C-w>l<C-w>h')
    '';
}
