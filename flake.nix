# flake.nix
{
    description = "canoe's main configuration flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland";
        xremap-flake.url = "github:xremap/nix-flake";
        hyprfocus-flake = {
            url = "github:vortexcoyote/hyprfocus";
            inputs.hyprland.follows = "hyprland";
        };

        vimplugin-cellular-automaton = {
            url = "github:Eandrju/cellular-automaton.nvim";
            flake = false;
        };
        vimplugin-canoe-mini-nvim = {
            url = "github:catinacanoe/mini.nvim";
            flake = false;
        };
    };

    outputs = { ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = inputs.nixpkgs.legacyPackages.${system};

        hyprfocus = inputs.hyprfocus-flake.packages.${pkgs.system}.hyprfocus;
        lib = inputs.home-manager.lib;
    in
    {
        nixosConfigurations."default" = inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
                inherit inputs;
            };
            modules = [
                ./config
            ];
        };

        homeConfigurations."canoe" = lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
                inherit inputs system hyprfocus;
            };
            modules = [
                ./home
                inputs.hyprland.homeManagerModules.default {
                    wayland.windowManager.hyprland = {
                        enable = true;
                        plugins = [ hyprfocus ];
                    };
                }
            ];
        };
    };
}
