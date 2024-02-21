let host = import ../ignore-hostname.nix; in {
    # remember to regenerate wallpapers if you change scheme
    col = import ./colors "gruvbox";
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

    window = let
        gaps = 7;
    in {
        border = if host == "nixbox" then 3 else 2;
        radius = if host== "nixbox" then 14 else 7;
        gaps-in = gaps;
        gaps-out = 2*gaps;
    };
}
