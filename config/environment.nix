# session.nix everything related to the graphical session. greeter + wm
{ config, pkgs, ... }:
{
    # WM
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
}
