{ pkgs, ... }: pkgs.writeShellScriptBin "sshkey" ''
[ -z "$1" ] && name="id-github-canoe" || name="$1"

[ -f "/home/canoe/.ssh/$name" ] || exit

echo "enter passphrase for password manager" # MAKE IT LOOP # TODO
passwd="$(gpg --pinentry-mode loopback -quiet -d "$PASSWORD_STORE_DIR/ssh/$name.gpg")"

ssh-add -L | grep -q "$(cat "/home/canoe/.ssh/$name.pub")" && exit

sleep 0.01 && wtype "$passwd" && wtype -k Return &
ssh-add "/home/canoe/.ssh/$name"
''
