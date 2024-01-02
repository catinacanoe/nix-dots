{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.nvim-colorizer-lua;
    type = "lua";
    config = /* lua */ ''
        require("colorizer").setup { user_default_options = {
	    RGB = true,
	    RRGGBB = true,
	    names = false,
            RRGGBBAA = true,
            AARRGGBB = true,
            rgb_fn = true,
            hsl_fn = true,
            css = true,
            css_fn = true,

	    mode = "virtualtext",
	}}
    '';
}
