{ pkgs, ... }: pkgs.writeShellScriptBin "sshkey" ''
[ -z "$1" ] && name="id-github-canoe" || name="$1"

[ -f "/home/canoe/.ssh/$name" ] || exit

ssh-add -L | grep -q "$(cat "/home/canoe/.ssh/$name.pub")" && exit

sleep 0.01 && wtype "$(pass "ssh/$name")" && wtype -k Return &
ssh-add "/home/canoe/.ssh/$name"
''
