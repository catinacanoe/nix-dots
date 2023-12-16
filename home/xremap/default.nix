{ mod, ... }:
let
    mod = "super";

    hypr = (import ./fn/hypr.nix);
    launch = (import ./fn/launch.nix);
    programs = (import ./modules/programs.nix);
in
{
    # activated due to the `exec` line in hypr conf
    xdg.configFile."xremap/config.yml".text = ''
# default.nix
default_mode: main
keymap:
  - mode: main
    remap:
        ${mod}-semicolon:
            ${hypr "killactive"}
        ${mod}-shift-semicolon:
            ${hypr "forcerendererreload"}
        ${mod}-ctrl-semicolon:
            ${launch "hyprctl kill"}

        ${(import ./modules/windows.nix) { inherit mod; }}
        ${(import ./modules/workspaces.nix) { inherit mod; }}
        ${(import ./modules/peripherals.nix) { inherit mod; }}

        ${mod}-p:
            ${launch "pw"}
        ${mod}-shift-p:
            ${launch "pw --interactive"}

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
