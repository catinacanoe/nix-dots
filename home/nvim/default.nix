# https://discourse.nixos.org/t/neovim-and-nixos-star-crossed-lovers/25568/15
# https://github.com/collinarnett/brew/blob/0169cc473d781352e8418660d1b20a2c30c2e84c/modules/home-manager/neovim/neovim.nix
{ pkgs, ... }:
let
    col = (import ../../rice).col;
    args = { inherit pkgs col; };
in
{
    programs.neovim = {
        enable = true;
        defaultEditor = true;

        plugins = with pkgs.vimPlugins; 
        (import ./plugins/telescope.nix args).plugins ++
        (import ./plugins/cmp.nix args).plugins ++
        [
            (import ./plugins/lspconfig.nix args).plugin
            (import ./plugins/cmp.nix args).plugin
            (import ./plugins/telescope.nix args).plugin
            (import ./plugins/luasnip.nix args).plugin
            (import ./plugins/treesitter.nix args)
            (import ./plugins/tsplayground.nix args)
            (import ./plugins/gruvbox.nix args)
            (import ./plugins/lualine.nix args)
            (import ./plugins/colorizer.nix args)
            (import ./plugins/indent.nix args)
            (import ./plugins/leap.nix args)
            (import ./plugins/autosave.nix args)
            (import ./plugins/autopairs.nix args)
            (import ./plugins/commentary.nix args)
            (import ./plugins/surround.nix args)
            (import ./plugins/gitsigns.nix args)
            (import ./plugins/toggleterm.nix args)
            (import ./plugins/undotree.nix args)
            repeat
            vim-lastplace
            vim-automkdir
            # supertab
            # true-zen https://github.com/pocco81/true-zen.nvim
        ];

        extraLuaConfig = ''
            ${(import ./config/set.nix)}

            ${(import ./config/remap-keymap.nix)}
            ${(import ./config/remap-semicolon.nix)}
            ${(import ./config/remap-navigation.nix)}
            ${(import ./config/remap-yank.nix)}
            ${(import ./config/remap-other.nix)}
        '';

        extraPackages = []
        ++ (import ./plugins/luasnip.nix args).packages
        ++ (import ./plugins/lspconfig.nix args).packages;
    };
}
