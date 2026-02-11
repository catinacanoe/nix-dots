{ config, ... }:
let xioxide_fn = ''[ "$1" == "$HOME" ] && return || return 1''; in
with config.programs.zsh.shellAliases;
/*bash*/ ''

e() { ${xioxide} cd "grep '/$'" pwd '${xioxide_fn}' dirs $@ && ${n}; }
ee() { e && e "$1" }
eo() { cd - > /dev/null && ${n}; }
ke() { ${k} "$1" && e "$1"; }

a() { ${xioxide} lf "grep '/$'" pwd '${xioxide_fn}' dirs $@; }
sy() {
    ${xioxide} "" "" pwd '${xioxide_fn}' dirs $@ | read file
    tmp=$(mktemp) && cp "$file" "$tmp" && echo "rm $tmp" | at now + 2 min && sioyek "$tmp"
}
A() { ${xioxide} lfcd "grep '/$'" pwd '${xioxide_fn}' dirs $@; }
h() { [ -z "$1" ] && "$EDITOR" . || ${xioxide} "$EDITOR" "" pwd '${xioxide_fn}' dirs $@; }

''
