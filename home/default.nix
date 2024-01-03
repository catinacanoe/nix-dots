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
        ./hyprland
        ./kitty
        ./sioyek
        ./remap
        ./crypt
        ./nvim
        ./gpg
        ./shell
        ./starship
        ./xdg
        ./pass
        ./git
        ./gitutils
        ./thefuck
        ./xioxide
        ./pw
        ./power
        ./lf
        ./mail
        ./bat
        ./mako
    ];

    services.ssh-agent.enable = true;

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
        MENU = "tofi";
    };
}
