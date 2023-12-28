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
}
