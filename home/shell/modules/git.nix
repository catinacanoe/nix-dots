{ config, ... }:
{
    g = "git";
    gy = "gitutils sync";
    gs = "gitutils status";
    gd = "gitutils diff";
    gii = "gitutils init";

    ga = "echo 'g add %%% && gs' | zargs";
    gaa = "ga .";
    gau = "ga -u";
    gc = "g commit";

    gll = "g pull";
    gsh = "g push";
    gf = "g fetch";
    gcl = "g clone";


    yy = "crypt sync";
    ys = "crypt status";
    yii = "crypt init";
    ycl = "crypt clone";

    yll = "crypt pull";
    ysh = "crypt push";
    yc = "crypt commit";
    yf = "crypt fetch";

    ye = "crypt encrypt";
    yd = "crypt decrypt";
}
