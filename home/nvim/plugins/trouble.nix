{ plugins, ... }:
let
    config = /* lua */ ''{
        "folke/trouble.nvim",

        lazy = true,
        cmd = {
            "Trouble",
            "TroubleClose",
            "TroubleToggle",
            "TroubleRefresh",
        },
        keys = {
            { "<leader>ex", "<cmd>TroubleToggle workspace_diagnostics<cr>" }
        },

        opts = {
            icons = false,
            fold_open = "v",
            fold_closed = ">",
            indent_lines = false,
            use_diagnostic_signs = true
        }
    }'';
in {
    plugin."${plugins}/trouble.lua".text = "return {${config}}";
}
