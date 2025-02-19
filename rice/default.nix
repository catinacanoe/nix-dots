let host = import ../ignore-hostname.nix; in {
    # remember to regenerate wallpapers if you change colorscheme
    col = import ./colors/gruvbox.nix;
    wall = import ./wall;
    test = "test";

    font = {
        name = "VictorMono";
        size = 13;
        full = let family = "Victor Mono"; in {
            inherit family;
            bold = "${family} Bold";
            italic = "${family} Italic";
            bold-italic = "${family} Bold Italic";
        };
    };

    monito = if host == "nixbox" then {
        scale = 1;
        width = 3840;
        height = 2160;
    } else if host == "nixpad" then {
        scale = 1.333333;
        width = 2560;
        height = 1600;
    } else {};

    monitor = let
        benq-pd3200u- = if host != "nixpad" then {
            scale = 1;
            width = 3840;
            height = 2160;
            fps = 60;
        } else { # on laptop because apparently hdmi doesnt support 4k60
            scale = 1;
            width = 2560;
            height = 1440;
            fps = 60;
        };
        thinkpad-e16- = {
            scale = 1.33333;
            width = 2560;
            height = 1600;
            fps = 60;
        };
        default- = {
            scale = 1;
            width = 1920;
            height = 1080;
            fps = 60;
        };
    in {
        default = if host == "nixbox" then benq-pd3200u-
                  else if host == "nixpad" then thinkpad-e16-
                  else default-;
        secondary = if host == "nixbox" then thinkpad-e16-
                    else if host == "nixpad" then benq-pd3200u-
                    else default-;

        port = if host == "nixbox" then {
            default = "DP-3";
            # secondary = "not installed yet"
        } else if host == "nixpad" then {
            default = "eDP-1";
            secondary = "HDMI-A-1";
        } else {};

        benq-pd3200u = benq-pd3200u-;
        thinkpad-e16 = thinkpad-e16-;
    };

    bar = {
        fontsize = 18;
        height = 35;
        cava = let h=3; in{
            height = h;
            width = h * (if host=="nixbox" then 20 else 15);
        };
    };

    window = let
        gaps = 7;
    in {
        border = if host == "nixbox" then 3 else 2;
        radius = if host== "nixbox" then 10 else 7;
        gaps-in = gaps;
        gaps-out = 2*gaps;
    };
}
