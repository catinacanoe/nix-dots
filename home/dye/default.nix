{ config, pkgs, ... }:
{
    home.packages = 
    [(pkgs.writeShellScriptBin "dye" (builtins.readFile ./dye))];
}
