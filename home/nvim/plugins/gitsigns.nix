{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.gitsigns-nvim;
    type = "lua";
    config = /* lua */ ''
        require('gitsigns').setup()
    '';
}
