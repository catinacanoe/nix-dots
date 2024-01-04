{ col, plugins, ... }:
let
    config = /* lua */ ''{
        "catinacanoe/mini.nvim",

        config = function(_, _)
            require("mini.misc").setup()
            MiniMisc.setup_auto_root({'.git', '.crypt', 'Makefile', 'README.md'})

            require("mini.animate").setup {
                open = { enable = false },
                close = { enable = false },
                resize = { enable = false },
            }

            require("mini.surround").setup {
                custom_surroundings = {
                    ['b'] = { output = { left = '(', right = ')' } },
                    [')'] = { output = { left = '(', right = ')' } },
                    ['('] = { output = { left = '( ', right = ' )' } },

                    ['B'] = { output = { left = '{', right = '}' } },
                    ['}'] = { output = { left = '{', right = '}' } },
                    ['{'] = { output = { left = '{ ', right = ' }' } },

                    ['s'] = { output = { left = '[', right = ']' } },
                    [']'] = { output = { left = '[', right = ']' } },
                    ['['] = { output = { left = '[ ', right = ' ]' } },

                    ['a'] = { output = { left = '<', right = '>' } },
                    ['>'] = { output = { left = '<', right = '>' } },
                    ['<'] = { output = { left = '< ', right = ' >' } },

                    ['"'] = { output = { left = '"', right = '"' } },
                    ['d'] = { output = { left = '"', right = '"' } },
                    ["'"] = { output = { left = "'", right = "'" } },
                    ["q"] = { output = { left = "'", right = "'" } },
                },
                n_lines = 30,
                search_method = "cover_or_next",
                silent = true,
            }

            require("mini.files").setup {
                mappings = {
                    close       = ',',
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

            vim.keymap.set("n", ",", MiniFiles.open)

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
        end,
    }'';
in {
    plugin."${plugins}/mini.lua".text = "return {${config}}";
}
