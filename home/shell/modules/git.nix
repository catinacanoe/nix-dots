{ ... }:
{
    g = "git";
    gy = "sshkey && gitutils sync";
    gd = "gitutils diff";
    gii = "gitutils init";

    gs = "g status";
    ga = "echo 'git add %%% && git status' | yargs";
    gaa = "ga .";
    gau = "ga -u";
    gc = "g commit";
    gco = "g checkout";
    gb = "g branch";

    gll = "sshkey && g pull";
    gsh = "sshkey && g push";
    gf = "sshkey && g fetch";
    gcl = "sshkey && g clone";


    cry = "crypt";
    yy = "sshkey && crypt sync";
    ys = "sshkey && crypt status";
    yii = "sshkey && crypt init";
    ycl = "sshkey && crypt clone";

    yll = "sshkey && crypt pull";
    ysh = "sshkey && crypt push";
    yc = "crypt commit";
    yf = "sshkey && crypt fetch";

    ye = "crypt encrypt";
    yd = "crypt decrypt";
}
