{ ... }:
{
    g = "git";
    gy = "sshkey && gitutils sync";
    gs = "gitutils status";
    gd = "gitutils diff";
    gii = "gitutils init";

    ga = "echo 'git add %%% && gitutils status' | yargs";
    gaa = "ga .";
    gau = "ga -u";
    gc = "g commit";

    gll = "sshkey && g pull";
    gsh = "sshkey && g push";
    gf = "sshkey && g fetch";
    gcl = "sshkey && g clone";


    cry = "crypt";
    yy = "sshkey && crypt sync";
    ys = "crypt status";
    yii = "crypt init";
    ycl = "sshkey && crypt clone";

    yll = "sshkey && crypt pull";
    ysh = "sshkey && crypt push";
    yc = "crypt commit";
    yf = "sshkey && crypt fetch";

    ye = "crypt encrypt";
    yd = "crypt decrypt";
}
