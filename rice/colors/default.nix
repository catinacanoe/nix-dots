theme-name:
let
    schemes."gruvbox" = (import ./out/gruvbox.nix);
    schemes."rosepine" = (import ./out/rosepine.nix);
    schemes."catppuccin" = (import ./out/catppuccin.nix);
    # nord
    # monokai
    # dracula
    # gigavolt
    # hopscotch
    # solarized
    # tokyo city
in
schemes."${theme-name}"
