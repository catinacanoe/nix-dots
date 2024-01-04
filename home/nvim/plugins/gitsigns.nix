{ plugins, ... }:
let
    config = /* lua */ ''{
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {},
    }'';
in {
    plugin."${plugins}/gitsigns.lua".text= "return {${config}}";
}
