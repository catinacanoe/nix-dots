{ col, plugins, rice, ... }:
let
    config = /* lua */ ''{
        "catinacanoe/mini.nvim",

        config = function(_, _)
            require("mini.misc").setup()
            MiniMisc.setup_auto_root({'.git', '.crypt', 'Makefile', 'README.md'})

            require("mini.surround").setup {
                custom_surroundings = {
                    b = {
                        input = { '%(().-()%)' },
                        output = { left = '(', right = ')' },
                    },

                    B = {
                        input = { '%{().-()%}' },
                        output = { left = '{', right = '}' },
                    },

                    s = {
                        input = { '%[().-()%]' },
                        output = { left = '[', right = ']' },
                    },

                    a = {
                        input = { '%<().-()%>' },
                        output = { left = '<', right = '>' },
                    },

                    d = {
                        input = { '%"().-()%"' },
                        output = { left = '"', right = '"' },
                    },
                    
                    q = {
                        input = { "%'().-()%'" },
                        output = { left = "'", right = "'" },
                    },
                },
                mappings = {
                    add = 'sa',
                    delete = 'sr',
                    replace = 'sd',
                    find = 'sf',
                    find_left = 'sF',
                    highlight = 'sh',
                    update_n_lines = 'sn',
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
                    vim.api.nvim_win_set_config(win_id, { border = '${if rice.style.rounding then "rounded" else "single"}' })
                    vim.api.nvim_win_set_option(win_id, 'winhighlight', 'FloatBorder:${col.fg.hex}')
                end,
            })
        end,
    }'';
in {
    plugin."${plugins}/mini.lua".text = "return {${config}}";
}
