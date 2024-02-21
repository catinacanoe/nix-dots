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
        } else let 
            sizing = /* toml */ ''
                size = "70% 70%"
                position = "15% 15%"
            '';
        in {
            term = sizing;
            browser = sizing;
            gpt = sizing;
        };

        termpad = name: command: /* toml */ ''
            [scratchpads.${name}]
            command = "${config.home.sessionVariables.TERMINAL} --class scratchpad ${command}"
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

    ${termpad "network" "netshell"}
    ${termpad "vpn" "sudo vpnshell"}
    ${termpad "nix" "nixshell"}

    ${focustermpad "browseshell" "browseshell"}
    ${focustermpad "launcher" "launcher"}
    ${focustermpad "menu" "menuui"}

    ${termpad "news" "newsboat"}
    ${termpad "qalc" "qalc"}
    ${termpad "bluetooth" "bluetoothctl"}

    [scratchpads.top]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad gotop"
    lazy = true
    ${size.browser}

    # BROWSER #
    ${browserpad "browser" "scratch about:blank" size.browser}
    ${browserpad "gpt" "gpt chat.openai.com" size.gpt}
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

