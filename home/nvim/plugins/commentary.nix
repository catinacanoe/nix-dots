{ plugins, ... }:
let
    config = /* lua */ ''{
        "tpope/vim-commentary",

        lazy = true,
        cmd = "Commentary",
        keys = {
            { "gcgc", mode = { "n", "v" } },
            { "gcc", mode = { "n", "v" } },
            { "gc", mode = { "n", "v" } },
        },

        init = function(_, _)
            vim.cmd [[autocmd FileType nix setlocal commentstring=#\ %s]]
        end,
    }'';
in {
    plugin."${plugins}/commentary.lua".text= "return {${config}}";
}
