{ plugins, ... }:
let
    config = /* lua */ ''{
        "numToStr/Comment.nvim",

        lazy = true,
        keys = {
            { "gc", mode = { "n", "v" } },
            { "gb", mode = { "n", "v" } },
            { "gcc", mode = { "n" } },
            { "gbc", mode = { "n" } },
            { "gca", mode = { "n" } },
            { "gci", mode = { "n" } },
            { "gco", mode = { "n" } },
        },

        opts = {
            pre_hook = function() require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() end,
            ignore = '^$',
            extra = {
                above = 'gca',
                below = 'gci',
                eol = 'gco',
            }
        },

        dependencies = {{
            "JoosepAlviste/nvim-ts-context-commentstring",
            opts = { enable_autocmd = false },
        }},
    }'';
in {
    plugin."${plugins}/comment.lua".text= "return {${config}}";
}
