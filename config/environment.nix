# session.nix everything related to the graphical session. greeter + wm
{ pkgs, ... }:
{
    # WM
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-kde ];
    };
}
