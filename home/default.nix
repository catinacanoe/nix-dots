# home.nix
{ config, pkgs, inputs, system, hyprfocus, lib, ... }:
let
    username = "canoe";
    homeDirectory = "/home/${username}";
  
    xremap = inputs.xremap-flake.packages.${system}.default;
    xremap-start = (import ./remap/start.nix { inherit pkgs homeDirectory xremap; });
in
{
    programs.home-manager.enable = true;
    home = {
        inherit username homeDirectory;
        stateVersion = "23.05";
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs = { overlays = [(final: prev: {
        vimPlugins = prev.vimPlugins // {
            cellular-automaton-nvim = prev.vimUtils.buildVimPlugin {
                name = "cellular-automaton";
                src = inputs.vimplugin-cellular-automaton;
            };
            canoe-mini-nvim = prev.vimUtils.buildVimPlugin {
                name = "canoe-mini-nvim";
                src = inputs.vimplugin-canoe-mini-nvim;
            };
        };
    })];};

    imports = [
        inputs.xremap-flake.homeManagerModules.default {services.xremap.config.na="na";}
        inputs.spicetify-nix.homeManagerModules.default
        ./bat
        ./cava
        ./cadence
        ./crypt
        ./discord
        ./dye
        ./eww
        ./firefox
        ./fzf
        ./git
        ./gitutils
        ./gpg
        ./gui
        ./hyprland
        ./imv
        ./kitty
        ./lf
        ./mail
        ./mako
        ./mpd
        ./mpv
        ./newsboat
        ./nvim
        ./pass
        ./power
        ./pw
        ./qutebrowser
        ./remap
        ./scrot
        ./shell
        ./sioyek
        ./spicetify
        ./starship
        ./swaylock
        ./thefuck
        ./wpp
        ./xdg
        ./xioxide
    ];

    services.ssh-agent.enable = true;
    programs.yt-dlp.settings.cookies-from-browser = config.home.sessionVariables.BROWSER;

    home.packages = with pkgs;
    [
        sutils
        xremap
        xremap-start
    ];

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
