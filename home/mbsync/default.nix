{ config, ... }:
{
    services.mbsync = {
        enable = true;
	preExec = ""; # runs before mbsync is called
	postExec = ""; # useful for running indexing tools
	frequency = "*:0/5"; # see docs, this is cron related
    };


    home.file.".mbsyncrc".source = ../../ignore/mbsyncrc;
}
