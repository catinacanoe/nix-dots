{ config, inputs, ... }:
let
    lib = inputs.home-manager.lib;
in
{
    programs.starship = {
        enable = true;
	enableZshIntegration = true;
	settings = {
	    add_newline = true;
	    format = "$git_status$directory";

	    directory = {
	        truncation_length = 0;
                truncate_to_repo = true;

                style = "cyan italic";
                format = "[$path]($style) ";
	    };

	    git_status = {
                style = "yellow italic bold";
                format = "[$ahead_behind$all_status]($style) ";

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
