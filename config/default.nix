# configuration.nix
{ config, pkgs, inputs, ... }: {
    imports = [ 
        ./ignore-hardware.nix # auto generated on install
        ./apps.nix
        ./boot.nix
    ];

    programs.hyprland.enable = true;
    services.seatd.enable = true;
    networking.networkmanager.enable = true;

    networking.hostName = import ../ignore-hostname.nix;

    nix.nixPath = [
        "nixpkgs=/home/canoe/.nix-defexpr/channels/nixos/"
        "nixos-config=/home/canoe/repos/nix-dots/config/default.nix"
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.canoe = {
        isNormalUser = true;
        description = "canoe";
        extraGroups = [ "networkmanager" "wheel" "uinput" "input" "seat"]; # "seat", "video"
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
    };
   
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05";
}
