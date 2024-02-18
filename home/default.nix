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
        ./bat
        ./cava
        ./crypt
        ./discord
        ./dye
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
        ./remap
        ./scrot
        ./shell
        ./sioyek
        ./starship
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
        BROWSER = "firefox";
        TERMINAL = "kitty";
        DMENU_PROGRAM = "tofi";

        MENUFIFO = "/tmp/menu.fifo";
    };
}
