{ config, ...}:
{
    programs.git = {
        enable = true;
	userName = "catinacanoe";
	userEmail = "catinacanoe@proton.me";
	aliases = {}; # see docs
	includes = []; # see docs

	extraConfig = {
	    gpg.format = "ssh";
	    user.signingkey = "${config.home.homeDirectory}/.ssh/id-github-canoe.pub";
	    init.defaultBranch = "main";
	};
    };
}
