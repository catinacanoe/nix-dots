{ plugins, ... }:
let
    config = /* lua */ ''{
        "mrjones2014/smart-splits.nvim",

        lazy = true,
        keys = {
            { "<s-left>", function()
                require('smart-splits').resize_left()
                require('bufresize').register()
            end},
            { "<s-up>", function()
                require('smart-splits').resize_up()
                require('bufresize').register()
            end},
            { "<s-down>", function()
                require('smart-splits').resize_down()
                require('bufresize').register()
            end},
            { "<s-right>", function()
                require('smart-splits').resize_right()
                require('bufresize').register()
            end},
        },

        opts = {
            resize_mode = {
                quit_key = ';',
                resize_keys = { 'n', 'i', 'a', 'o' },
                silent = true,
                hooks = {
                    on_enter = function() vim.notify('Entering resize mode') end,
                    on_leave = function() vim.notify('Exiting resize mode') end,
                },
            },
        },

        dependencies = "kwkarlwang/bufresize.nvim",
    }'';
in {
    plugin."${plugins}/smartsplits.lua".text = "return {${config}}";
}
