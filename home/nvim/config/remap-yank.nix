# stuff related to registers and yanking
{ ... }: /* lua */ ''
vim.keymap.set({"n", "v"}, "<leader>d", '"_d') --delete to void register
vim.keymap.set("v", "<leader>p", '"_dp') --paste without losing current yank
''
