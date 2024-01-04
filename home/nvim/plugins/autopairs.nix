{ plugins, ... }:
let
    config = /* lua */ ''{
        "windwp/nvim-autopairs",

        lazy = true,
        event = {
            "InsertEnter",
            "CursorHold",
        },

        opts = {},
    }'';
in {
    plugin."${plugins}/autopairs.lua".text = "return {${config}}";
}
