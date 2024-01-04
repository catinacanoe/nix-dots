{ plugins, ... }:
let
    config = /* lua */ ''{
        "airblade/vim-rooter",

        lazy = false,

        config = function()
            vim.g.rooter_patterns = vim.list_extend(vim.g.rooter_patterns or {},
                { ".crypt" })
        end
    }'';
in
{
    plugin."${plugins}/rooter.lua".text = "return {${config}}";
}
