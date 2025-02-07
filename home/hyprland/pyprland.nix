{ config, pkgs, ... }:
{
    pypr.text = let
        size = if (import ../../ignore-hostname.nix) == "nixbox" then {
            term = /* toml */ ''
                size = "50% 50%"
                position = "25% 40%"
            '';

            browser = /* toml */ ''
                size = "60% 65%"
                position = "20% 28%"
            '';

            gpt = /* toml */ ''
                size = "50% 50%"
                position = "25% 40%"
            '';

            tinyterm = /* toml */ ''
                size = "50% 20%"
                position = "25% 40%"
            '';
        } else let 
            sizing = /* toml */ ''
                size = "70% 70%"
                position = "15% 15%"
            '';
        in {
            term = sizing;
            browser = sizing;
            gpt = sizing;
            tinyterm = /* toml */ ''
                size = "30% 16%"
                position = "35% 42%"
            '';
        };

        tinytermpad = name: command: /* toml */ ''
            [scratchpads.${name}]
            command = "${config.home.sessionVariables.TERMINAL} --class scratchpad ${command}"
            lazy = true
            ${size.tinyterm}
        '';

        termpad = name: command: /* toml */ ''
            [scratchpads.${name}]
            command = "${config.home.sessionVariables.TERMINAL} --class scratchpad ${command}"
            lazy = true
            ${size.term}
        '';

        focuspad = name: command: /* toml */ ''
            [scratchpads.${name}]
            command = "${command}"
            lazy = true
            ${size.term}
        '';

        focustermpad = name: command: /* toml */ ''
            [scratchpads.${name}]
            command = "${config.home.sessionVariables.TERMINAL} --class scratchpad ${command}"
            unfocus = "hide"
            lazy = true
            ${size.term}
        '';

        browserpad = name: args: sizing: /* toml */ ''
            [scratchpads.${name}]
            command = "${config.home.sessionVariables.BROWSER} --no-remote -P ${args}"
            lazy = true
            ${sizing}
        '';
    in /* toml */ ''
    [pyprland]
    plugins = [ "scratchpads" ]

    # TERMINAL #
    ${termpad "term" ""}

    ${termpad "network" "sudo netshell"}
    ${termpad "nix" "nixshell"}

    ${focustermpad "browseshell" "browseshell"}
    ${focustermpad "launcher" "launcher"}
    ${focustermpad "menu" "menuui"}

    ${termpad "news" "newsboat"}
    ${termpad "mtag" "mustagger"}
    ${termpad "player" "player"}
    ${termpad "qalc" "qalc"}
    ${termpad "bluetooth" "blueshell"}

    ${tinytermpad "gpgpass" "$XDG_REPOSITORY_DIR/pw/unlock.sh"}

    [scratchpads.top]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad gotop"
    lazy = true
    ${size.browser}

    # BROWSER #
    ${browserpad "browser" "scratch" size.browser}
    ${browserpad "calendar" "calendar" size.browser}
    ${browserpad "gpt" "gpt" size.gpt}
    '';

    activation = "$DRY_RUN_CMD ${pkgs.pyprland}/bin/pypr reload > /dev/null";

    hypr.text = let
        rules = match: ''
        windowrulev2 = float,${match}
        windowrulev2 = workspace special silent,${match}
        '';
    in /* bash */ ''
        exec-once = pypr

        ${rules "class:^(scratchpad)$"}
    '';
}

