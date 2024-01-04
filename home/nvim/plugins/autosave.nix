{ plugins, ... }:
let
    config = /* lua */ ''{
        "pocco81/auto-save.nvim",

        lazy = true,
        event = {
            "InsertLeave",
            "TextChanged",
            "CursorHold",
        },
        cmd = "ASToggle",

        opts = { execution_message = { message = "" } }
    }'';
in {
    plugin."${plugins}/autosave.lua".text= "return {${config}}";
}
