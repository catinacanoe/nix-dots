{ col, plugins, ... }:
let
    config = /* lua */ ''{
        -- "ggandor/leap.nvim",
        url = "https://codeberg.org/andyg/leap.nvim",

        lazy = true,
        keys = {
            { "<tab>", "<Plug>(leap)", mode = {'n', 'x', 'o'} },
            { "<s-tab>", "<Plug>(leap-anywhere)", mode = {'n', 'x', 'o'} },
            -- { "<s-tab>", "<Plug>(leap-backward)", mode = {'n', 'x', 'o'} },
            -- vim.keymap.set('o', '.', '<Plug>(leap-forward-till)')
            -- vim.keymap.set('o', ',', '<Plug>(leap-backward-till)')
        },

        config = function(_, _)
            vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { bg = '#${col.purple.hex}', fg = '#${col.fg.hex}' })
            vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { bg = '#${col.purple.hex}', fg = '#${col.bg.hex}' })
        end
    }'';
in {
    plugin."${plugins}/leap.lua".text= "return {${config}}";
}
