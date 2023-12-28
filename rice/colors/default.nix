theme-name:
let
    schemes."gruvbox" = (import ./gruvbox.nix);
    schemes."rosepine" = (import ./rosepine.nix);
    schemes."catppuccin" = (import ./catppuccin.nix);
    # nord
    # monokai
    # dracula
    # gigavolt
    # hopscotch
    # solarized
    # tokyo city
in
with schemes."${theme-name}";
{
    inherit
        t0 t1 t2 t3 t4 t5 t6 t7
	red orange yellow green aqua blue purple brown;
    bg = t0;
    mg = t4;
    fg = t7;

    rgb01 = with rgb01_; {
        inherit
            t0 t1 t2 t3 t4 t5 t6 t7
	    red orange yellow green aqua blue purple brown;
        bg = t0;
        mg = t4;
        fg = t7;
    };
}
