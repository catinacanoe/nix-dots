{ config, pkgs, ... }:
{
    pypr.text = /* toml */ ''
    [pyprland]
    plugins = [
        "scratchpads",
    ]

    # TERMINAL #
    [scratchpads.term]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    [scratchpads.network]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad -e nmtui"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    [scratchpads.vpn]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad -e sudo vp"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    [scratchpads.nix]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad -e nixshell"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    [scratchpads.qalc]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad -e qalc"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    [scratchpads.browsepad]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad -e bp"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    [scratchpads.bluetooth]
    command = "${config.home.sessionVariables.TERMINAL} --class scratchpad -e bluetoothctl"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    # BROWSER #
    [scratchpads.browser]
    command = "${config.home.sessionVariables.BROWSER} --no-remote -P scratch about:blank"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    [scratchpads.gpt]
    command = "${config.home.sessionVariables.BROWSER} --no-remote -P gpt chat.openai.com"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"

    # GUI #
    [scratchpads.discord]
    command = "killall .Discord-wrapped && discord"
    unfocus = "hide"
    size = "70% 70%"
    position = "15% 15%"
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

