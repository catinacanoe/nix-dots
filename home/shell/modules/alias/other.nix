{
    sio = ''echo "tmp=$(mktemp) && cp \"%%%\" \$tmp && echo \"rm \$tmp\" | at now + 2 min && sioyek \$tmp" | yargs'';

    hst = "tac $ZDOTDIR/.zsh_history | awk -F ';' '{ print $2 }' | fzf | tr -d '\\n' | wtype -";

    o = "e ../";
    oo = "e ../..";
    ooo = "e ../../..";
    oooo = "e ../../../..";
    ooooo = "e ../../../../..";
    oooooo = "e ../../../../../..";

    k = "mkdir -p";
    l = "touch";
    c = "chmod";
    r = "trash-put";
    z = "exit";

    src = "exec zsh";

    t = "eza -Ta";
    n = "eza -a1lo --no-user --no-permissions --no-filesize --no-time";

    q = "qalc";
}
