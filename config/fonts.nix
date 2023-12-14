{ config, pkgs, ... }:
let
    mainfont = "VictorMono";
in
{
    fonts = {
        packages = with pkgs; [
            (nerdfonts.override { fonts = [ "FiraCode" ]; })
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
