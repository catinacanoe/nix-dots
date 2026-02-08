{ config, ...}:
{
    programs.git = {
        enable = true;

        settings = {
            user = {
                name = "catinacanoe";
                email = "catinacanoe@proton.me";
                signingkey = "${config.home.homeDirectory}/.ssh/id-github-canoe.pub";
            };

            # aliases = {}; # see docs
            # includes = []; # see docs

            gpg.format = "ssh";
            init.defaultBranch = "main";
        };
    };

    programs.diff-so-fancy = {
        enable = true;
        enableGitIntegration = true;

        pagerOpts = [ "--tabs=4" "-R" "-F" ];

        settings = {
            markEmptyLines = false;
            useUnicodeRuler = true;
        };

    };
}
