{ config, ... }:
{
    # input (xremap requires this)
    hardware.uinput.enable = true;

    # audio
    # sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true; # pulse-pw compat layer
        wireplumber.enable = true;
    };


    # bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };

    # wifi
    networking = {
        networkmanager.enable = true;
        nameservers = ["1.1.1.1"];
    };
    # vpn configurations (folder copy)
    environment.etc."wireguard" = {
        source = ../private/wireguard;
    };


    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false; DANGEROUS
}
