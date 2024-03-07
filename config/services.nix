{ config, pkgs, ... }:
{
    systemd.user.services.xremap.enable = false; # we are forced to create this but it is broken

    security.pam.services.swaylock = {};

    services.openssh.enable = true;
    programs.ssh = {
        startAgent = true;
        # askPassword = ""; see docs
        agentTimeout = "5h";
    };

    services.atd = {
        enable = true;
        allowEveryone = true;
    };

    # printing
    services.printing.enable = true;
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

    services.logind = {
        powerKey = "ignore";
        powerKeyLongPress = "ignore";
        lidSwitch = "ignore";
        rebootKey = "ignore";
        rebootKeyLongPress = "ignore";
        suspendKey = "ignore";
        suspendKeyLongPress = "ignore";
        hibernateKey = "ignore";
        hibernateKeyLongPress = "ignore";
        lidSwitchExternalPower = "ignore";
    };

    systemd.services."hyprland-suspend" = if (import ../ignore-hostname.nix) == "nixbox" then {
        enable = true;

        description = "force hyprland to suspend (nvidia compat)";

        script = "killall -STOP .Hyprland-wrapp";

        before = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
            "nvidia-suspend.service"
            "nvidia-hibernate.service"
        ];

        wantedBy = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
        ];
    } else {};

    systemd.services."hyprland-resume" = if (import ../ignore-hostname.nix) == "nixbox" then {
        enable = true;

        description = "resume hyprland from suspend (nvidia compat)";

        script = "killall -CONT .Hyprland-wrapp";

        after = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
            "nvidia-resume.service"
        ];

        wantedBy = [
            "systemd-suspend.service"
            "systemd-hibernate.service"
        ];
    } else {};
}
