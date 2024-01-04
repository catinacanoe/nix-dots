{ ... }:
let
    mod = "super";

    hypr = (import ./fn/hypr.nix);
    launch = (import ./fn/launch.nix);
    programs = (import ./modules/programs.nix);
in
{
    wayland.windowManager.hyprland.extraConfig = ''
    exec = xremap-start
    bind = SUPER_ALT, F4, exit,

    bindl=,switch:on:Lid Switch,exec,power suspend
    bind=,XF86PowerOff,exec,power suspend

    bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
    bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    bind = CTRL, XF86MonBrightnessUp, exec, brightnessctl set 1%+
    bind = CTRL, XF86MonBrightnessDown, exec, brightnessctl set 1%-

    bind = SUPER, mouse:274, killactive # super+mmb
    bindm = SUPER, mouse:272, movewindow # super+lmb
    bindm = SUPER, mouse:273, resizewindow # super+rmb
    '';

    xdg.configFile."xremap/config.yml".text = ''
# default.nix
default_mode: main
keymap:
  - mode: main
    remap:
        ${(import ./modules/windows.nix) { inherit mod; }}
        ${(import ./modules/workspaces.nix) { inherit mod; }}
        ${(import ./modules/peripherals.nix) { inherit mod; }}

        ${mod}-p:
            ${launch "pw"}
        ${mod}-shift-p:
            ${launch "pw --interactive"}

        ${mod}-semicolon:
            remap:
                ${(import ./modules/power.nix) { inherit mod; }}

        ${mod}-l:
            remap:
                ${programs { direction = "l"; inherit mod; }}
        ${mod}-tab:
            remap:
                ${programs { direction = "u"; inherit mod; }}
        ${mod}-u:
            remap:
                ${programs { direction = "d"; inherit mod; }}
        ${mod}-q:
            remap:
                ${programs { direction = "r"; inherit mod; }}
# default.nix
    '';
}
