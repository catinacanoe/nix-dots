{ pkgs, plugins, ... }:
let
    config = /* lua */ ''{
        "L3MON4D3/LuaSnip",

        lazy = true,
        event = "BufEnter *",

        config = function(_, _)
            require("luasnip.loaders.from_vscode").load()
        end,

        dependencies = {
            "rafamadriz/friendly-snippets",
        }
    }'';
in {
    plugin."${plugins}/luasnip.lua".text = "return {${config}}";

    dependencies = with pkgs; [ lua54Packages.jsregexp ];
}
