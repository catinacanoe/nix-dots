{ ... }@args: {
    xdg.configFile = import ./userstyles.nix // { "qutebrowser/userscripts".source = ./userscripts; };

    home.sessionVariables.QT_QPA_PLATFORM = "wayland";

    programs.qutebrowser = {
        enable = true;
        loadAutoconfig = true; # don't allow settings changes inside the app
        enableDefaultBindings = false; # define all bindings urself

        extraConfig = (import ./options.nix).extraConfig;
        settings = (import ./options.nix).settings // {
            colors = import ./colors.nix;
        };
        
        keyBindings = import ./binds.nix args;

        aliases = {};
        quickmarks = {};

        searchEngines = { # instead of set.url.searchEngines
            DEFAULT = "https://www.google.com/search?q={}";
        };
    };
}
