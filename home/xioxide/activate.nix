{ config, ... }:
''
out="$(${config.programs.zsh.shellAliases.xioxide} reload)"
echo "$out" | head -n 5
''
