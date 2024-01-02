{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.playground;
    type = "lua";
    config = /* lua */ ''
        require("nvim-treesitter.configs").setup {
            playground = {
                enable = true,
                keybindings = {
                    toggle_query_editor = 'l',
                    toggle_hl_groups = 'h',
                    toggle_injected_languages = 't',
                    toggle_anonymous_nodes = 'k',
                    toggle_language_display = 'I',
                    focus_language = 'f',
                    unfocus_language = 'F',
                    update = 'R',
                    goto_node = '<cr>',
                    show_help = '?',
                },
            }
        }
    '';
}
