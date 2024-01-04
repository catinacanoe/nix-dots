# I use semicolin to lead all of my 'esc' binds
{ ... }: /* lua */ ''
-- basic exit
vim.keymap.set({"i", "v", "x", "s"}, ";n", "<Esc>")
vim.keymap.set("n", ";n", "ZZ")
vim.keymap.set("c", ";n", "<c-c>")

-- cmd
vim.keymap.set("n", ";w", vim.cmd.write)

-- actually typing a semicolon
vim.keymap.set("i", ";e", "<Esc>A;<Esc>")
vim.keymap.set("i", ";a", ";<Esc>")

-- typing a char before exit
vim.keymap.set("i", ";.", ".<Esc>")

-- certain action after exit
vim.keymap.set("i", ";l", "<Esc>o")
vim.keymap.set("i", ";L", "<Esc>O")
vim.keymap.set("i", ";k", "<Esc>A")
''
