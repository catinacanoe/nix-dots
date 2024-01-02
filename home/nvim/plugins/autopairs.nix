{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.nvim-autopairs;
    type = "lua";
    config = /* lua */ "require('nvim-autopairs').setup {}";
}
