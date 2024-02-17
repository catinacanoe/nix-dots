# also configures swaylock
{ config, pkgs, ... }:
{
    home.packages = 
    [(pkgs.writeShellScriptBin "dye" (builtins.readFile ./dye))];
}
