{ config, ... }:
''
#!/usr/bin/env bash

type="$(file --dereference --brief --mime-type -- "$f")"

case "$type" in
    inode/directory) lf --remote "send $id cd \"$f\"" ;;
    image/*) mpv "$f" ;;
    video/*) mpv "$f" ;;
    audio/*) mpv "$f" ;;
    */pdf) ${config.programs.zsh.shellAliases.sy} "$f" ;;
    *) lf --remote "send $id \$nvim \"$f\"" ;;
esac
''
