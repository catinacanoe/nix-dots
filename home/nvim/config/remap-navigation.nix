# navigating through nvim (tabs, windows, ...)
{ ... }: /* lua */ ''
-- win nav
vim.keymap.set({"n", "v"}, "<leader>n", "<C-w><Left>")
vim.keymap.set({"n", "v"}, "<leader>a", "<C-w><Up>")
vim.keymap.set({"n", "v"}, "<leader>i", "<C-w><Down>")
vim.keymap.set({"n", "v"}, "<leader>o", "<C-w><Right>")

-- win resize
vim.keymap.set({"n", "v"}, "<leader>we", "<C-w>=")

-- win open
vim.keymap.set({"n", "v"}, "<leader>N", function()
    vim.opt.splitright = false
    vim.cmd.vsplit()
end)
vim.keymap.set({"n", "v"}, "<leader>A", function()
    vim.opt.splitbelow = false
    vim.cmd.split()
end)
vim.keymap.set({"n", "v"}, "<leader>I", function()
    vim.opt.splitbelow = true
    vim.cmd.split()
end)
vim.keymap.set({"n", "v"}, "<leader>O", function()
    vim.opt.splitright = true
    vim.cmd.vsplit()
end)

-- tabs
vim.keymap.set("n", ";t", vim.cmd.tabclose)
vim.keymap.set({"n", "v"}, "<leader>ts", "<cmd>tab split<CR>")
vim.keymap.set({"n", "v"}, "<leader>tn", vim.cmd.tabprevious)
vim.keymap.set({"n", "v"}, "<leader>ta", "<cmd>tabmove +<CR>")
vim.keymap.set({"n", "v"}, "<leader>ti", "<cmd>tabmove -<CR>")
vim.keymap.set({"n", "v"}, "<leader>to", vim.cmd.tabnext)

-- buffers
-- vim.keymap.set("n", ";h", vim.cmd.bdel)
vim.keymap.set("n", "<leader>hn", vim.cmd.bprev)
vim.keymap.set("n", "<leader>ha", vim.cmd.blast)
vim.keymap.set("n", "<leader>hi", vim.cmd.bfirst)
vim.keymap.set("n", "<leader>ho", vim.cmd.bnext)
vim.keymap.set("n", "<BS>", "<C-^>") --previous buffer
vim.keymap.set("n", "<Left>", "<C-o>") -- jump positions within buffer
vim.keymap.set("n", "<Right>", "<C-i>")
''
