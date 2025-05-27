let host = import ../ignore-hostname.nix; in {
    # remember to regenerate wallpapers if you change colorscheme
    col = import ./colors/catppuccin.nix;
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

    monitor = let
        benq-pd3200u- = {
            name = "BenQ PD3200U";
            scale = 1.06666;
            width = 3840;
            height = 2160;
            fps = 60;
            priority = 0;
        };
        thinkpad-e16- = {
            name = "0x160E";
            scale = 1.33333;
            width = 2560;
            height = 1600;
            fps = 60;
            priority = 1;
        };
    in if host == "nixbox" then {
        primary = benq-pd3200u-//{
            port = "DP-1";
        };

        secondary = thinkpad-e16-//{
            port = "ERROR-in-rice-default-nix";
            name = "ERROR-in-rice-default-nix"; # name will be diff: the headless plug
        };
    } else if host == "nixpad" then {
        primary = benq-pd3200u-//{
            port = "HDMI-A-1";
            fps = 30; # if we want 60fps over HDMI we must use 1440p 
        };

        secondary = thinkpad-e16-//{
            port = "eDP-1";
        };
    } else {};

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
