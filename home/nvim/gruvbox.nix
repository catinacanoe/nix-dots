vimPlugins: col:
with vimPlugins; {
    plugin = gruvbox-nvim;
    type = "lua";
    config = /* lua */ ''
        require("gruvbox").setup({
            italic = {
	        operators = true,
	    },
            transparent_mode = true,
            palette_overrides = {
                dark0 = "#${col.bg}",
                dark0_hard = "#${col.bg}",
		dark0_soft = "#${col.bg}",
                dark1 = "#${col.t1}",
                dark2 = "#${col.t2}",
                dark3 = "#${col.t3}",
                dark4 = "#${col.t3}",
                light4 = "#${col.t4}",
                light3 = "#${col.t4}",
                light2 = "#${col.t5}",
                light1 = "#${col.t6}",
	        light0 = "#${col.fg}",
		light0_hard = "#${col.fg}",
		light0_soft = "#${col.fg}",
                gray = "#${col.mg}",

                light_red_hard = "#${col.red}",
		light_red = "#${col.red}",
		light_red_soft = "#${col.red}",
		bright_red = "#${col.red}",
		neutral_red = "#${col.red}",
		faded_red = "#${col.red}",

                bright_yellow = "#${col.yellow}",
		neutral_yellow = "#${col.yellow}",
		faded_yellow = "#${col.yellow}",

                bright_orange = "#${col.orange}",
		neutral_orange = "#${col.orange}",
		faded_orange = "#${col.orange}",

                dark_green_hard = "#${col.green}",
		dark_green = "#${col.green}",
		dark_green_soft = "#${col.green}",
		light_green_hard = "#${col.green}",
		light_green = "#${col.green}",
		light_green_soft = "#${col.green}",
		bright_green = "#${col.green}",
		neutral_green = "#${col.green}",
		faded_green = "#${col.green}",

                dark_aqua_hard = "#${col.aqua}",
		dark_aqua = "#${col.aqua}",
		dark_aqua_soft = "#${col.aqua}",
		light_aqua_hard = "#${col.aqua}",
		light_aqua = "#${col.aqua}",
		light_aqua_soft = "#${col.aqua}",
		bright_aqua = "#${col.aqua}",
		neutral_aqua = "#${col.aqua}",
		faded_aqua = "#${col.aqua}",

                bright_blue = "#${col.blue}",
		neutral_blue = "#${col.blue}",
		faded_blue = "#${col.blue}",

                bright_purple = "#${col.purple}",
		neutral_purple = "#${col.purple}",
		faded_purple = "#${col.purple}",

                dark_red_hard = "#${col.brown}",
		dark_red = "#${col.brown}",
		dark_red_soft = "#${col.brown}",
            },
        })

        vim.o.background = "dark"
        vim.cmd([[colorscheme gruvbox]])
    '';
}
