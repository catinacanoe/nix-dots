{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
    type = "lua";
    config = /* lua */ ''
        require("nvim-treesitter.configs").setup {
            highlight = {
                enable = true
            }
        }
    '';
}
