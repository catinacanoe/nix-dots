# session.nix everything related to the graphical session. greeter + wm
{ ... }:
{
    # WM
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
}
