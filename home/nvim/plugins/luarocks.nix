{ plugins, ... }:
let
    config = /* lua */ ''{
        "vhyrro/luarocks.nvim",
        lazy = false,
        priority = 1000,
        config = true,
    }'';
in {
    plugin."${plugins}/luarocks.lua".text = "return {${config}}";
}
