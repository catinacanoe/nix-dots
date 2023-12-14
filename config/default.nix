# configuration.nix
{ config, pkgs, ... }:
{
  imports = [ 
      ../ignore/hardware-config.nix # auto generated on install
      ./apps.nix
      ./environment.nix # desktop environemnt setup basically
      ./fonts.nix
      ./locale.nix
      ./peripheral.nix
      ./services.nix
  ];

  nix.nixPath = [
    "nixpkgs=/home/canoe/.nix-defexpr/channels/nixos/"
    "nixos-config=/home/canoe/repos/nix-dots/config/default.nix"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixpad";

  # for xremap
  #users.groups.uinput.members = [ "canoe" ];
  #users.groups.input.members = [ "canoe" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.canoe = {
    isNormalUser = true;
    description = "canoe";
    extraGroups = [ "networkmanager" "wheel" "uinput" "input" ];
    packages = with pkgs; [];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}
