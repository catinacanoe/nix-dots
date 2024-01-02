{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.toggleterm-nvim;
    type = "lua";
    config = /* lua */ ''
        require('toggleterm').setup {
            size = function(term)
                if term.direction == "horizontal" then
                    scale = vim.o.lines * 0.2
                    min = 13
                    if scale > min then
                        return scale
                    else
                        return min
                    end
                elseif term.direction == "vertical" then
                    scale = vim.o.columns * 0.3
                    min = 40
                    if scale > min then
                        return scale
                    else
                        return min
                    end
                else
                    return 20
                end
            end,
            open_mapping = [[<C-l>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = false,
            shading_factor = 3,
            start_in_insert = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            autochdir = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
                width = function() return math.floor(vim.o.columns * 0.8) end,
                height = function() return math.floor(vim.o.lines * 0.8) end,
            },
        }

        vim.keymap.set("n", "<leader>la", "<cmd>ToggleTerm direction=float<CR>")
        vim.keymap.set("n", "<leader>li", "<cmd>ToggleTerm direction=horizontal<CR>")
        vim.keymap.set("n", "<leader>lo", "<cmd>ToggleTerm direction=vertical<CR>")
    '';
}
