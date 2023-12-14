# flake.nix
{
    description = "canoe's main configuration flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        xremap-flake.url = "github:xremap/nix-flake";
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
        nixosConfigurations."nixpad" = inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [ ./config ];
        };

        homeConfigurations."canoe" = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs system; };
            modules = [
                ./home
                inputs.hyprland.homeManagerModules.default {wayland.windowManager.hyprland.enable = true;}
            ];
        };
    };
}
