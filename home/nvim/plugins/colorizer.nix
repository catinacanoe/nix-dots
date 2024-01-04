{ plugins, ... }:
let
    config = /* lua */ ''{
        "nvchad/nvim-colorizer.lua",

        lazy = true,
        event = "VeryLazy",

        opts = { user_default_options = {
            names = false,
            RGB = false,
            RRGGBB = true,
            RRGGBBAA = true,
            AARRGGBB = true,
            rgb_fn = true,
            hsl_fn = true,
            css = true,
            css_fn = true,

            mode = "virtualtext",
        }}
    }'';
in {
    plugin."${plugins}/colorizer.lua".text = "return {${config}}";
}
