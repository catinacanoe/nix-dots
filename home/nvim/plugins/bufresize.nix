{ plugins, ... }:
let
    config = /* lua */ ''{
        "kwkarlwang/bufresize.nvim",

        lazy = true,
        event = {
            "BufWinEnter",
            "WinEnter",
            "VimResized",
        },
        cmd = "ASToggle",

        opts = {
            register = {
                keys = {},
                trigger_events = { "BufWinEnter", "WinEnter" },
            },
            resize = {
                keys = {},
                trigger_events = { "VimResized" },
                increment = false,
            },
        }
    }'';
in {
    plugin."${plugins}/bufresize.lua".text= "return {${config}}";
}
