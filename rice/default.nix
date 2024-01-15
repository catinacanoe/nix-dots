{
    # remember to regenerate wallpapers if you change scheme
    col = import ./colors "gruvbox";

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

    window = {
        border = 2;
        radius = 7;
        gaps-out = 17;
        gaps-in = 7;
    };

    wall.url = "https://i.imgur.com/2e6DOl2.jpeg";
    wall.url-blur = "https://i.imgur.com/ryPT1V8.jpeg";
    wall.url-dim = "https://i.imgur.com/FSEigyT.jpeg";
}
