# cyf workspaces
# rsth taken by workspaces
# p is pass

# z is scrot
# ltabuq is windows / launching
# m naio is window controls
# w is browsepad
# . is scratchpads
# ; is power options

#  |(j)| c | y | f |(k)|     | z | l |tab| u | q |
#  | r | s | t | h |(d)|     | m | n | a | i | o |
#|(ret)|(v)|(g)| p |(b)|     |(x)| w | . | ; |(')|

# technically <num layer> is taken by volume controls

{ ... }:
let
    mod = if (import ../../ignore-hostname.nix) == "nixbox" then "super-alt" else "super";
    hypr = (import ./fn/hypr.nix);
    launch = (import ./fn/launch.nix);
    programs = (import ./modules/programs.nix);
in { xdg.configFile."xremap/config.yml".text = ''
# default.nix
default_mode: main
keymap:
  - mode: main
    remap:
        ${(import ./modules/windows.nix) { inherit mod; }}
        ${(import ./modules/workspaces.nix) { inherit mod; }}
        ${(import ./modules/peripherals.nix) { inherit mod; }}
        ${(import ./modules/dropdown.nix) { inherit mod; }}

        ${mod}-enter:
            ${launch "sleep 0.7 && wtype -M ctrl -k l -k c && sleep 0.7 && wl-paste >> /tmp/mustagger.in"}

        ${mod}-p:
            ${launch "pw"}
        ${mod}-shift-p:
            ${launch "pw --interactive"}
        ${mod}-z:
            ${launch "scrot"}

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

    wayland.windowManager.hyprland.extraConfig = ''
    exec = xremap-start
    bind = SUPER_ALT, F4, exit,

    bindl=,switch:on:Lid Switch,exec,power suspend
    bind=,XF86PowerOff,exec,power suspend

    bind = , XF86MonBrightnessUp, exec, setbright 3%+
    bind = , XF86MonBrightnessDown, exec, setbright 3%-
    bind = , XF86AudioPlay, exec, plyr toggle
    bind = CTRL, XF86MonBrightnessUp, exec, setbright 1%+
    bind = CTRL, XF86MonBrightnessDown, exec, setbright 1%-

    bind = SUPER, mouse:274, killactive # super+mmb
    bindm = SUPER, mouse:272, movewindow # super+lmb
    bindm = SUPER, mouse:273, resizewindow # super+rmb
    '';

    xdg.configFile."libinput-gestures.conf".text = ''
        gesture swipe up 4 wtype -M ctrl -M shift -k tab -m ctrl -m shift
        gesture swipe down 4 wtype -M ctrl -k tab -m ctrl
    '';
}
