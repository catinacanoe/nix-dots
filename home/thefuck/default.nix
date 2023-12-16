{ config, ... }:
{
    programs.thefuck = {
        enable = true;
	enableZshIntegration = true;
    };

    xdg.configFile."thefuck/settings.py".text = ''
    exclude_rules = [ 'fix_file' ]
    '';
}
