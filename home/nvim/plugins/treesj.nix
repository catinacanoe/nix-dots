{ plugins, ... }:
let
    config = /* lua */ ''{
        "wansmer/treesj",

        lazy = true,
        cmd = {
            "TSJJoin",
            "TSJSplit",
            "TSJToggle",
        },
        keys = {
            { "<leader>et", vim.cmd.TSJToggle }
        },

        opts = { use_default_keymaps = false },
    }'';
in {
    plugin."${plugins}/treesj.lua".text= "return {${config}}";
}
