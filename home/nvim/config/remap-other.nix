# any miscellaneous remaps
/* lua */ ''
vim.keymap.set("n", "<leader>z", "zR") -- unfold everything
vim.keymap.set("n", "U", "<C-r>") -- redo
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("v", "<leader>s", '"hy:%s/<c-r>h/<c-r>h/g<left><left>')
''
