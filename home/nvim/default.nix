# https://discourse.nixos.org/t/neovim-and-nixos-star-crossed-lovers/25568/15
# https://github.com/collinarnett/brew/blob/0169cc473d781352e8418660d1b20a2c30c2e84c/modules/home-manager/neovim/neovim.nix
{ pkgs, ... }:
let
    col = (import ../../rice).col;
    args = { inherit pkgs col; plugins = "nvim/lua/plugins"; };
in {
    xdg.configFile =
        (import ./plugins/autopairs.nix          args).plugin //
        (import ./plugins/autosave.nix           args).plugin //
        (import ./plugins/bufresize.nix          args).plugin //
        (import ./plugins/cellular-automaton.nix args).plugin //
        (import ./plugins/cmp.nix                args).plugin //
        (import ./plugins/colorizer.nix          args).plugin //
        (import ./plugins/commentary.nix         args).plugin //
        (import ./plugins/gitblame.nix           args).plugin //
        (import ./plugins/gitsigns.nix           args).plugin //
        (import ./plugins/gruvbox.nix            args).plugin //
        (import ./plugins/indent.nix             args).plugin //
        (import ./plugins/leap.nix               args).plugin //
        (import ./plugins/lspconfig.nix          args).plugin //
        (import ./plugins/lualine.nix            args).plugin //
        (import ./plugins/luasnip.nix            args).plugin //
        (import ./plugins/mini.nix               args).plugin //
        (import ./plugins/neorg.nix              args).plugin //
        (import ./plugins/noice.nix              args).plugin //
        (import ./plugins/smartsplits.nix        args).plugin //
        (import ./plugins/telescope.nix          args).plugin //
        (import ./plugins/toggleterm.nix         args).plugin //
        (import ./plugins/treesitter.nix         args).plugin //
        (import ./plugins/treesj.nix             args).plugin //
        (import ./plugins/trouble.nix            args).plugin //
        (import ./plugins/tsplayground.nix       args).plugin //
        (import ./plugins/undotree.nix           args).plugin //
        (import ./plugins/winshift.nix           args).plugin //
        {
            "${args.plugins}/other.lua".text = ''
                return {
                    "tpope/vim-repeat",
                    "farmergreg/vim-lastplace",
                    "benizi/vim-automkdir",
                    "gpanders/editorconfig.nvim",
                    "sQVe/sort.nvim",
                }
            '';
        };
    
    programs.neovim = {
        enable = true;
        defaultEditor = true;

        extraPackages =
            (import ./plugins/luasnip.nix args).dependencies ++
            (import ./plugins/lspconfig.nix args).dependencies ++
            [];

        extraLuaConfig = /* lua */ ''
            local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
            if not vim.loop.fs_stat(lazypath) then
                vim.fn.system({
                    "git",
                    "clone",
                    "--filter=blob:none",
                    "https://github.com/folke/lazy.nvim.git",
                    "--branch=stable", -- latest stable release
                    lazypath,
                })
            end
            vim.opt.rtp:prepend(lazypath)

            ${(import ./config/set.nix args)}

            ${(import ./config/remap-keymap.nix args)}
            ${(import ./config/remap-navigation.nix args)}
            ${(import ./config/remap-operator.nix args)}
            ${(import ./config/remap-other.nix args)}
            ${(import ./config/remap-semicolon.nix args)}
            ${(import ./config/remap-yank.nix args)}

            require("lazy").setup("plugins", {
                install = { colorscheme = { "gruvbox" } },
                ui = {
                    size = { with = 0.7, height = 0.7 },
                    border = "rounded",
                    icons = {
                        cmd = "> ",
                        config = "* ",
                        event = "% ",
                        ft = "~ ",
                        init = "@ ",
                        import = "~ ",
                        keys = "^ ",
                        lazy = "z ",
                        loaded = "+ ",
                        not_loaded = "- ",
                        plugin = "& ",
                        runtime = "v ",
                        require = "o ",
                        source = "s ",
                        start = "v ",
                        task = "t ",
                        list = {
                            "*",
                            ">",
                            "*",
                            "-",
                        },
                    },
                }
            })
        '';
    };
}
