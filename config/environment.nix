# session.nix everything related to the graphical session. greeter + wm
{ pkgs, inputs, ... }:
let
    hypr-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
    # WM
    programs.hyprland = {
        enable = true;
    };

    hardware.graphics = {
        enable = true;
        package = pkgs.mesa;

        enable32Bit = true;
        package32 = pkgs.pkgsi686Linux.mesa;
    };

    services.xserver.videoDrivers = [ "amdgpu" ];
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.amdgpu = {
        initrd.enable = true;
        legacySupport.enable = true;
        opencl.enable = true;
    };

    # nixpkgs.overlays = [
    #     (final: prev: {
    #         mesa = hypr-pkgs.mesa;
    #     })
    # ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # xdg.portal = {
    #     enable = true;
    #     extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-kde ];
    # };
}
