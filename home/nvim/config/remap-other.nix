# any miscellaneous remaps
{ ... }@args: /* lua */ ''
vim.keymap.set("n", "U", "<cmd>silent redo<cr>")
vim.keymap.set("n", "u", "<cmd>silent undo<cr>")
vim.keymap.set("n", "<c-z>", "zR") -- unfold everything
vim.keymap.set("n", "<c-x>", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("v", "<leader>s", '"hy:%s/<c-r>h/<c-r>h/g<left><left> <BS>')
vim.keymap.set({ "n", "v" }, "<c-s>", ':%s///g<left><left><left>')

vim.keymap.set("n", "<c-.>", "@@")

vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<cr>", "gd")

-- zen mode basically lmfao
vim.g.focus_running = false

vim.keymap.set("n", "<leader>y", function()
    if vim.g.focus_running then -- disable it
        vim.g.focus_running = false
        vim.notify("welcome back . . .")

        vim.cmd "tab close"
        vim.opt.laststatus = 3
        vim.opt.signcolumn = "yes"

        require("lualine").setup { ${(import ../plugins/lualine.nix args).sections} }
    else -- enable it
        vim.g.focus_running = true
        vim.notify("entering flow . . .")

        vim.cmd "tab split"
        vim.opt.laststatus = 0
        vim.opt.signcolumn = "no"

        require("lualine").setup { sections = {}, winbar = {} }
    end
end)
''
