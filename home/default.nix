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
        stateVersion = "25.11";
    };

    imports = [
        ./hyprland
    ];

    services.ssh-agent.enable = true;

    home.sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
        EDITORS = "nvim";
        BROWSER = "org.qutebrowser.qutebrowser";
        BROWSERS = "firefox\nBrave-browser\norg.qutebrowser.qutebrowser";
        TERMINAL = "kitty";
        TERMINALS = "kitty";
        DMENU_PROGRAM = "menu";
        NIX_BUILD_SHELL = "zsh";
        MANPAGER = "manpager";
    };
}
