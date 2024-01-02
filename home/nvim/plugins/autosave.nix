{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.autosave-nvim;
    type = "lua";
    config = /* lua */ "require('autosave').setup {}";
}
