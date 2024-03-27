{ pkgs, ... }: pkgs.writeShellScriptBin "mptoggle" ''
function getvol() {
    mpc volume | awk '{ print $2 }' | sed 's|%$||'
}

volume="$(getvol)"

if mpc | sed -n 2p | grep -q '\[playing\]'; then
    while [ "$(getvol)" != "0" ]; do
        mpc volume -10
    done

    mpc pause
else
    mpc volume 0
    mpc play

    while [ "$(getvol)" -lt "$volume" ]; do
        mpc volume +10
    done
fi

mpc volume "$volume"
''
