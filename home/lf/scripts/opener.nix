{ config, ... }:
/* bash */ ''
#!/usr/bin/env bash

type="$(file --dereference --brief --mime-type -- "$f")"

case "$type" in
    inode/directory) lf --remote "send $id cd \"$f\"" ;;
    image/*) imv "$f" ;;
    video/*) mpv "$f" ;;
    audio/*) 
        if [ -f "$XDG_MUSIC_DIR/$(basename "$f")" ]; then
            mpc update
            mpc insert "$(basename "$f")"
            mpc play
            mpc next
        else
            mpv "$f"
        fi ;;
    */pdf) ${config.programs.zsh.shellAliases.sio} "$f" ;;
    application/zip) mcomix "$f" ;; # cbz file
    *) lf --remote "send $id \$nvim \"$f\"" ;;
esac
''
