{ plugins, ... }:
let
    config = /* lua */ ''{
        "nvim-treesitter/nvim-treesitter",

        lazy = true,
        event = "VeryLazy",

        config = function(_, _)
            require("nvim-treesitter.configs").setup {
                ensure_installed = "all",
                highlight = { enable = true },
                indent = { enable = true },
            }
        end,

        dependencies = {
            "calops/hmts.nvim", -- automatic injection with nix home-manager
        }
    }'';
in {
    plugin."${plugins}/treesitter.lua".text = "return {${config}}";
}
