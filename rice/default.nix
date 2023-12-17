{
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
}
