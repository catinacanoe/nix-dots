{ pkgs, ... }:
let
    rice = (import ../../rice);
    cursor = {
        size = 28;
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
    };
in {
    home.pointerCursor = cursor // {
        x11.enable = true;
        gtk.enable = true;
    };

    gtk = {
        enable = true;

        font = {
            name = rice.font.full.family;
            size = rice.font.size;
        };

        cursorTheme = cursor;
    };
}
