# flake.nix
{
    description = "canoe's main configuration flake";

    inputs = {
        # 23.11 works, hypr runs but terminals don't open

        # https://channels.nixos.org/
        nixpkgs.url = "nixpkgs/nixos-24.11"; # nixos-unstable / nixos-24.11

        # https://github.com/nix-community/home-manager/branches
        home-manager = {
            url = "github:nix-community/home-manager/release-24.11"; # master / release-24.11
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland";
        xremap-flake.url = "github:xremap/nix-flake";

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
                inherit inputs system;
            };
            modules = [
                ./home
                inputs.hyprland.homeManagerModules.default {
                    wayland.windowManager.hyprland = {
                        enable = true;
                    };
                }
            ];
        };
    };
}
