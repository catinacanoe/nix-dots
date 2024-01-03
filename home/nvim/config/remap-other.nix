# any miscellaneous remaps
/* lua */ ''
vim.keymap.set("n", "<c-r>", "zR") -- unfold everything
vim.keymap.set("n", "U", "<c-r>") -- redo
vim.keymap.set("n", "<c-x>", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("v", "<c-s>", '"hy:%s/<c-r>h/<c-r>h/g<left><left> <BS>') -- ' <BS>' updates buffer highlight
vim.keymap.set("n", "<c-s>", ':%s///g<left><left><left>')

vim.keymap.set("n", "<c-.>", "@@")
''
