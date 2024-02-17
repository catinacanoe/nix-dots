{ ... }:
with (import ../../rice/default.nix).col;
{
    programs.imv = {
        enable = true;
        settings = {
            options.background = bg.hex;
            binds = let pan = "30"; zoom = "7%"; in {
                "<semicolon>" = "quit";

                n = "pan ${pan} 0";
                a = "pan 0 ${pan}";
                i = "pan 0 -${pan}";
                o = "pan -${pan} 0";
                
                l = "zoom actual";
                "<Tab>" = "zoom +${zoom}";
                u = "zoom -${zoom}";
            };
        };
    };
}
