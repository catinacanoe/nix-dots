# any miscellaneous remaps
{ ... }@args: /* lua */ ''
vim.keymap.set("n", "U", "<cmd>silent redo<cr>")
vim.keymap.set("n", "u", "<cmd>silent undo<cr>")
vim.keymap.set("n", "<c-z>", "zR") -- unfold everything
vim.keymap.set("n", "<c-x>", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("v", "<leader>s", '"hy:%s/<c-r>h//g<left><left> <BS>')
vim.keymap.set("n", "<c-s>", ':%s///g<left><left><left>')
vim.keymap.set("v", "<c-s>", ':s///g<left><left><left>')

vim.keymap.set("n", "<c-w>", 'Vg<c-g><esc>')
vim.keymap.set("v", "<c-w>", 'g<c-g><esc>')

vim.keymap.set("n", "<c-.>", "@@")
vim.keymap.set("n", "cc", "cc<esc>cc")

vim.keymap.set({"n", "v", "i"}, "<c-c>", function()
    vim.g.cmp_running = not vim.g.cmp_running
    print("toggled completion " .. (vim.g.cmp_running and "on" or "off"))
end)

vim.keymap.set("i", "#", " <bs>#") -- fix bad indenting

-- indent
vim.keymap.set("n", "<c-t>", ">>")
vim.keymap.set("n", "<c-d>", "<<")
vim.keymap.set("v", "<c-t>", ">gv")
vim.keymap.set("v", "<c-d>", "<gv")

-- incr/decr number
vim.keymap.set("n", "+", "<c-a>")
vim.keymap.set("n", "-", "<c-x>")

vim.keymap.set("n", "<cr>", "gd")

-- zen mode basically lmfao
vim.g.focus_running = false

vim.keymap.set("n", "<leader>m", function()
    if vim.g.focus_running then -- disable it
        vim.g.focus_running = false

        vim.cmd "tab close"
        vim.o.laststatus = vim.g.focus_laststatus
        vim.o.signcolumn = vim.g.focus_signcolumn
        vim.o.nu = vim.g.focus_nu
        vim.o.rnu = vim.g.focus_rnu

        require("lualine").setup { ${(import ../plugins/lualine.nix args).sections} }
    else -- enable it
        vim.g.focus_running = true

        vim.cmd "tab split"

        vim.g.focus_laststatus = vim.o.laststatus
        vim.o.laststatus = 0

        vim.g.focus_signcolumn = vim.o.signcolumn
        vim.o.signcolumn = "no"

        vim.g.focus_nu = vim.o.nu
        vim.o.nu = false

        vim.g.focus_rnu = vim.o.rnu
        vim.o.rnu = false

        require("lualine").setup { sections = {}, winbar = {} }
    end
end)
''
