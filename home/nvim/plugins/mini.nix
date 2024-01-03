{ pkgs, col, ... }:
{
    plugin = pkgs.vimPlugins.canoe-mini-nvim;
    type = "lua";
    config = /* lua */ ''
        require("mini.surround").setup {}

        require("mini.animate").setup {
            open = { enable = false },
            close = { enable = false },
            resize = { enable = false },
        }

        require("mini.files").setup {
            mappings = {
                close       = '<CR>',
                go_in       = '_',
                go_in_plus  = 'o',
                go_out      = 'n',
                go_out_plus = '_',
                reset       = '<BS>',
                reveal_cwd  = '@',
                show_help   = 'g?',
                synchronize = 'w',
                trim_left   = '<',
                trim_right  = '>',
            },

            options = {
                use_as_default_explorer = true,
            },

            windows = {
                preview = true,
                width_focus = 30,
                width_nofocus = 20,
                width_preview = 50,
            },
        }

        vim.keymap.set("n", "<CR>", MiniFiles.open)


        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesWindowOpen',
            callback = function(args)
                local win_id = args.data.win_id
                vim.api.nvim_win_set_config(win_id, { border = 'rounded' })
                vim.api.nvim_win_set_option(win_id, 'winhighlight', 'FloatBorder:${col.fg}')
            end,
        })

        -- custom additions
        vim.cmd("hi MiniFilesBorder guifg=#${col.fg}")

        vim.cmd("hi MiniFilesCursorLine guifg=#${col.aqua}")
        vim.cmd("hi MiniFilesCursorLine guibg=#${col.bg}")

        vim.cmd("hi MiniFilesTitle guifg=#${col.fg}")
        vim.cmd("hi MiniFilesTitleFocused guifg=#${col.fg}")

        vim.cmd("hi MiniFilesFile guifg=#${col.aqua}")
    '';
}
