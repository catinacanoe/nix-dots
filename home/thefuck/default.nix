{ ... }:
{
    programs.thefuck = {
        enable = true;
        enableZshIntegration = true;
    };

    xdg.configFile."thefuck/settings.py".text = /* python */ ''
        exclude_rules = [ 'fix_file' ]
    '';
}
