{ config, ...}:
{
    programs.git = {
        enable = true;
        settings = {
            alias = {}; # see docs
            # includes = []; # see docs

            user = {
                name = "catinacanoe";
                email = "catinacanoe@proton.me";
            };

            gpg.format = "ssh";
            user.signingkey = "${config.home.homeDirectory}/.ssh/id-github-canoe.pub";
            init.defaultBranch = "main";
        };
    };
    

    programs.diff-so-fancy = {
        enable = true;
        enableGitIntegration = true;

        pagerOpts = [ "--tabs=4" "-R" "-F" ];

        settings = {
            useUnicodeRuler = true;
            markEmptyLines = false;

        };
    };
}
