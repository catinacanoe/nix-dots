{ pkgs, ... }: pkgs.writeShellScriptBin "manpager" ''
TMPFILE="$(mktemp)"
cat | ansifilter > "$TMPFILE"

nvim \
-c 'set ft=man' \
-c 'normal gg' \
-c 'lua vim.o.laststatus = 0; vim.o.signcolumn = "no"; vim.o.nu = false; vim.o.rnu = false; require("lualine").setup { sections = {}, winbar = {} }' \
-c 'nnoremap <silent> <buffer> j n' \
-c 'nnoremap <silent> <buffer> J N' \
-c 'nnoremap <silent> <buffer> k a' \
-c 'nnoremap <silent> <buffer> K A' \
"$TMPFILE"
''
