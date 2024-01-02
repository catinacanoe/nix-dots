{ col, pkgs, ... }:
{
    plugin = pkgs.vimPlugins.leap-nvim;
    type = "lua";
    config = /* lua */ ''
        vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { bg = '#${col.purple}', fg = '#${col.fg}' })
        vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { bg = '#${col.purple}', fg = '#${col.bg}' })

        vim.keymap.set({'n', 'x', 'o'}, '<Tab>', '<Plug>(leap-forward-to)')
        vim.keymap.set({'n', 'x', 'o'}, '<S-Tab>', '<Plug>(leap-backward-to)')

        -- vim.keymap.set('o', '.', '<Plug>(leap-forward-till)')
        -- vim.keymap.set('o', ',', '<Plug>(leap-backward-till)')
    '';
}
