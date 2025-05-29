# configuration.nix
{ config, pkgs, inputs, ... }: let
    col = (import ../rice).col;
in
{
    imports = [ 
        ./ignore-hardware.nix # auto generated on install
        ./hardware.nix
        ./apps.nix
        ./environment.nix
        ./fonts.nix
        ./locale.nix
        ./peripheral.nix
        ./services.nix
        ./battery.nix
    ];

    # nixpkgs.config.allowUnfree = true;
    system.autoUpgrade.enable = true;

    networking.hostName = import ../ignore-hostname.nix;

    nix.nixPath = [
        "nixpkgs=/home/canoe/.nix-defexpr/channels/nixos/"
        "nixos-config=/home/canoe/repos/nix-dots/config/default.nix"
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.preLVMCommands = /*sh*/ ''
        echo -en "\e]P0${col.bg.hex}" #black
        echo -en "\e]P8${col.t3.hex}" #darkgrey
        echo -en "\e]P1${col.brown.hex}" #darkred
        echo -en "\e]P9${col.red.hex}" #red
        echo -en "\e]P2${col.green.hex}" #darkgreen
        echo -en "\e]PA${col.green.hex}" #green
        echo -en "\e]P3${col.orange.hex}" #brown
        echo -en "\e]PB${col.yellow.hex}" #yellow
        echo -en "\e]P4${col.blue.hex}" #darkblue
        echo -en "\e]PC${col.blue.hex}" #blue
        echo -en "\e]P5${col.purple.hex}" #darkmagenta
        echo -en "\e]PD${col.purple.hex}" #magenta
        echo -en "\e]P6${col.aqua.hex}" #darkcyan
        echo -en "\e]PE${col.aqua.hex}" #cyan
        echo -en "\e]P7${col.t5.hex}" #lightgrey
        echo -en "\e]PF${col.fg.hex}" #white
        clear
    '';
   
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
