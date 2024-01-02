{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.surround-nvim;
    type = "lua";
    config = /* lua */ ''
        require("surround").setup {
            mappings_style = "sandwich",
            map_insert_mode = false,
        }
    '';
}
