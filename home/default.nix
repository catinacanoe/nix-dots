# home.nix
{ config, pkgs, inputs, system, lib, ... }:
let
    username = "canoe";
    homeDirectory = "/home/${username}";
in
{
    programs.home-manager.enable = true;
    home = {
        inherit username homeDirectory;
        stateVersion = "24.11";
    };

    imports = [ ./hyprland ];
}
