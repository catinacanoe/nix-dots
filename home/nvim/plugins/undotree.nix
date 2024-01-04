{ plugins, ... }:
let
    config = /* lua */ ''{
        "mbbill/undotree",

        lazy = true,
        keys = {
            { "<leader>u", ':UndotreeToggle<CR><C-w>l<C-w>h' }
        },
        cmd = {
            "UndotreeFocus",
            "UndotreeHide",
            "UndotreePersistUndo",
            "UndotreeShow",
            "UndotreeToggle",
        },
    }'';
in {
    plugin."${plugins}/undotree.lua".text = "return {${config}}";
}
