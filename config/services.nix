{ config, ... }:
{
    systemd.user.services.xremap.enable = false; # we are forced to create this but it is broken

    security.pam.services.swaylock = {};

    services.openssh.enable = true;
    programs.ssh = {
        startAgent = true;
        # askPassword = ""; see docs
        agentTimeout = "5h";
    };
}
