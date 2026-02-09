{ config, pkgs, ... }:
{
    systemd.user.services.xremap.enable = false; # we are forced to create this but it is broken

    security.pam.services.swaylock = {};

    services.openssh.enable = true;

    services.ssh-agent.enable = true;
    programs.ssh = {
        enable = true;
        startAgent = true;
        # askPassword = ""; see docs
        agentTimeout = "5h";
    };

    services.seatd = {
        enable = true;
    };

    services.atd = {
        enable = true;
        allowEveryone = true;
    };

    # printing
    services.printing = {
        enable = true;
        drivers = [
            pkgs.gutenprint # brother uses the hl1250 drivers
            pkgs.gutenprintBin
            pkgs.hplip
            pkgs.hplipWithPlugin
        ];
    };

    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

    services.logind.settings.Login = {
        HandlePowerKey = "ignore";
        HandlePowerKeyLongPress = "ignore";
        HandleLidSwitch = "ignore";
        HandleRebootKey = "ignore";
        HandleRebootKeyLongPress = "ignore";
        HandleSuspendKey = "ignore";
        HandleSuspendKeyLongPress = "ignore";
        HandleHibernateKey = "ignore";
        HandleHibernateKeyLongPress = "ignore";
        HandleLidSwitchExternalPower = "ignore";
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
