{ config, ... }:
{
    programs.thefuck = {
        enable = true;
	enableZshIntegration = true;
	#enableInstantMode = true;
    };

    programs.zsh.shellAliases.fk = "fuck";

    xdg.configFile."thefuck/settings.py".text = ''
    exclude_rules = [ 'fix_file' ]
    '';
}
