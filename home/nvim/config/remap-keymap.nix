# just accomodations for my keymap mostly

{ ... }: /* lua */ ''
local modes = {"n", "v", "s", "x", "o"}

vim.api.nvim_del_keymap("x", "a%")

vim.keymap.set(modes, "h", "i")
vim.keymap.set(modes, "k", "a")
vim.keymap.set(modes, "j", "n")
vim.keymap.set(modes, "l", "o")

vim.keymap.set(modes, "H", "I")
vim.keymap.set(modes, "K", "A")
vim.keymap.set(modes, "J", "N")
vim.keymap.set(modes, "L", "O")

vim.keymap.set(modes, "r", "d")
vim.keymap.set(modes, "R", "D")
vim.keymap.set(modes, "d", "r")
vim.keymap.set(modes, "D", "R")

vim.keymap.set(modes, "n", "h")
vim.keymap.set({"v", "s", "x", "o"}, "a", "k")
vim.keymap.set({"v", "s", "x", "o"}, "i", "j")
vim.keymap.set(modes, "o", "l")
vim.keymap.set("n", "a", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "i", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "N", "mzJ`z")
vim.keymap.set({"v", "s", "x", "o"}, "N", "H")

vim.keymap.set("v", "A", ":m '<-2<cr>gv=gv") -- moves line up in visual mode
vim.keymap.set("n", "A", "<C-u>") -- goes up and down a page, keeping cursor centered
vim.keymap.set("n", "<up>", "<C-u>")
vim.keymap.set("o", "A", "K")

vim.keymap.set("v", "I", ":m '>+1<cr>gv=gv")
vim.keymap.set("n", "I", "<c-d>")
vim.keymap.set("n", "<down>", "<C-d>")
vim.keymap.set("o", "I", "J")

vim.keymap.set(modes, "o", "l")
''
