{ config, ... }:
{
    # input (xremap requires this)
    hardware.uinput.enable = true;

    # audio
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true; # pulse-pw compat layer
    };


    # bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };

    # wifi
    networking = {
        networkmanager.enable = true;
    };
    environment.etc."wireguard/vpn.conf".text = ''
        [Interface]
        # Key for main
        # Bouncing = 1
        # NAT-PMP (Port Forwarding) = off
        # VPN Accelerator = on
        PrivateKey = EGSPUQLc1QwLSPRcctR23ow1M9KCqaFh4QTTQeR8r2k=
        Address = 10.2.0.2/32
        DNS = 10.2.0.1

        [Peer]
        # US-FREE#415060
        PublicKey = oGVahl/rkt0i22DILrVpPSmYZmqcmSup/HQ/upVf2Vg=
        AllowedIPs = 0.0.0.0/0
        Endpoint = 138.199.35.120:51820
    '';

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
}
