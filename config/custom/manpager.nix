{ pkgs, ... }: pkgs.writeShellScriptBin "manpager" ''
TMPFILE="$(mktemp)"
cat | ansifilter > "$TMPFILE"

nvim \
-c 'set ft=man' \
-c 'normal gg' \
-c 'lua vim.o.laststatus = 0' \
-c 'lua vim.o.signcolumn = "no"' \
-c 'lua vim.o.nu = false' \
-c 'lua vim.o.rnu = false' \
-c 'lua require("lualine").setup { sections = {}, winbar = {} }' \
"$TMPFILE"
''
