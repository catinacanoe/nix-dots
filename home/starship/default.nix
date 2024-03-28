{ ... }:
{
    programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = 
        let
            dirstyle = "cyan italic";
            gitstyle = "blue";
            gitstylealt = "yellow bold";
            nixshellstyle = "red italic";
        in
        {
            add_newline = true;
            format = "$env_var$git_status$directory";

            env_var = {
                variable = "IN_NIX_SHELL";
                format = "[$env_value](${nixshellstyle}) ";
            };

            directory = {
                truncation_length = 0;
                truncate_to_repo = true;

                format = "[$path](${dirstyle}) ";
            };

            git_status = {
                format = "[$ahead_behind](${gitstyle})[$all_status](${gitstylealt}) ";

                up_to_date = "->";
                ahead      = ">>";
                behind     = "<<";
                conflicted = "><";
                diverged   = "><";

                untracked = " nw";
                stashed   = " $$";
                modified  = " ch";
                staged    = " gc";
                renamed   = " mv";
                deleted   = " rm";
            };
        };
    };
}
