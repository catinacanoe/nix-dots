{ config, pkgs, ... }:
{
    pypr.text = let
        termpad = name: command: /* toml */ ''
            [scratchpads.${name}]
            command = "${config.home.sessionVariables.TERMINAL} --class scratchpad ${command}"
            unfocus = "hide"
            ${(import ./ignore-pypr.nix).term}
        '';

        browserpad = name: args: sizing: /* toml */ ''
            [scratchpads.${name}]
            command = "${config.home.sessionVariables.BROWSER} --no-remote -P ${args}"
            unfocus = "hide"
            ${sizing}
        '';
    in /* toml */ ''
    [pyprland]
    plugins = [ "scratchpads" ]

    # TERMINAL #
    ${termpad "term" ""}
    ${termpad "network" "nmtui"}
    ${termpad "news" "newsboat"}
    ${termpad "vpn" "sudo vp"}
    ${termpad "nix" "nixshell"}
    ${termpad "qalc" "qalc"}
    ${termpad "browsepad" "pb"}
    ${termpad "bluetooth" "bluetoothctl"}

    # BROWSER #
    ${browserpad "browser" "scratch about:blank" (import ./ignore-pypr.nix).browser}
    ${browserpad "gpt" "gpt chat.openai.com" (import ./ignore-pypr.nix).gpt}
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

