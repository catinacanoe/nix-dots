{ pkgs, ... }:
{
    plugin = {
        plugin = pkgs.vimPlugins.luasnip;
        type = "lua";
        config = /* lua */ ''
        '';
    };

    packages = with pkgs; [ lua54Packages.jsregexp ];
}
