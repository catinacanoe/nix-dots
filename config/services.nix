{ config, ... }:
{
    systemd.user.services.xremap.enable = false; # we are forced to create this but it is broken

    services.openssh.enable = true;
    programs.ssh = {
        startAgent = true;
        # askPassword = ""; see docs
        agentTimeout = "5h";
    };
}
