{ config, pkgs, ... }:
let
    mainfont = (import ../rice).font.name;
in
{
    fonts = {
        packages = with pkgs; [
            nerd-fonts.fira-code
            victor-mono
            monocraft
            scientifica
            comic-mono
        ];

        fontconfig.defaultFonts = {
            serif = [ mainfont "FiraCode" ];
            sansSerif = [ mainfont "FiraCode" ];
            monospace = [ mainfont "FiraCode" ];
        };
    };
}
