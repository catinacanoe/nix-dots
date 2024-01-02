# navigating through nvim (tabs, windows, ...)
/* lua */ ''
-- win nav
vim.keymap.set({"n", "v"}, "<leader>n", "<C-w><Left>")
vim.keymap.set({"n", "v"}, "<leader>a", "<C-w><Up>")
vim.keymap.set({"n", "v"}, "<leader>i", "<C-w><Down>")
vim.keymap.set({"n", "v"}, "<leader>o", "<C-w><Right>")

-- win resize
vim.keymap.set({"n"}, "<S-Left>", "5<C-w>>")
vim.keymap.set({"n"}, "<S-Up>", "2<C-w>+")
vim.keymap.set({"n"}, "<S-Down>", "2<C-w>-")
vim.keymap.set({"n"}, "<S-Right>", "5<C-w><")
vim.keymap.set({"n", "v"}, "<leader>we", "<C-w>=")

-- win open
vim.keymap.set({"n", "v"}, "<leader>wi", vim.cmd.split)
vim.keymap.set({"n", "v"}, "<leader>wo", vim.cmd.vsplit)

-- tabs
vim.keymap.set({"n", "v"}, "<leader>ts", "<cmd>tab split<CR>")
vim.keymap.set({"n", "v"}, "<leader>tn", vim.cmd.tabprevious)
vim.keymap.set({"n", "v"}, "<leader>ta", "<cmd>tabmove +<CR>")
vim.keymap.set({"n", "v"}, "<leader>ti", "<cmd>tabmove -<CR>")
vim.keymap.set({"n", "v"}, "<leader>to", vim.cmd.tabnext)

-- buffers
vim.keymap.set("n", "<BS>", "<C-^>") --previous buffer
vim.keymap.set("n", "<Left>", "<C-o>") -- jump positions within buffer
vim.keymap.set("n", "<Right>", "<C-i>")
''
