# stuff related to registers and yanking
{ ... }: /* lua */ ''
vim.keymap.set({"n", "v"}, "<c-d>", '"_d') --delete to void register
vim.keymap.set("v", "<c-p>", '"_dp') --paste without losing current yank
''
