# operator pending remaps
{ ... }: /* lua */ ''
vim.keymap.set({"o", "v"}, "ha", "i<")
vim.keymap.set({"o", "v"}, "ka", "a<")

vim.keymap.set({"o", "v"}, "hs", "i[")
vim.keymap.set({"o", "v"}, "ks", "a[")

vim.keymap.set({"o", "v"}, "hd", 'i"')
vim.keymap.set({"o", "v"}, "kd", 'a"')

vim.keymap.set({"o", "v"}, "hq", "i'")
vim.keymap.set({"o", "v"}, "kq", "a'")
''
