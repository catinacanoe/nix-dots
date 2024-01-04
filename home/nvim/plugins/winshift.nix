{ plugins, ... }:
let
    config = /* lua */ ''{
        "sindrets/winshift.nvim",

        lazy = true,
        keys = {
            { "<leader>wn", "<cmd>WinShift left<cr>" },
            { "<leader>wa", "<cmd>WinShift up<cr>" },
            { "<leader>wi", "<cmd>WinShift down<cr>" },
            { "<leader>wo", "<cmd>WinShift right<cr>" },
            { "<leader>wN", "<cmd>WinShift far_left<cr>" },
            { "<leader>wA", "<cmd>WinShift far_up<cr>" },
            { "<leader>wI", "<cmd>WinShift far_down<cr>" },
            { "<leader>wO", "<cmd>WinShift far_right<cr>" },
        },
        cmd = {
            "WinShift",
        },
    }'';
in {
    plugin."${plugins}/winshift.lua".text = "return {${config}}";
}
