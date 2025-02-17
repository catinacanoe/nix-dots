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

    monitor = if host == "nixbox" then {
        scale = 1.2;
        width = 3840;
        height = 2160;
    } else if host == "nixpad" then {
        scale = 1.333333;
        width = 2560;
        height = 1600;
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
