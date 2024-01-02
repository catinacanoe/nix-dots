{ pkgs, ... }:
{
    plugin = pkgs.vimPlugins.commentary;
    type = "lua";
    config = /* lua */ ''
        vim.cmd [[
        autocmd FileType nix setlocal commentstring=#\ %s
        ]]
    '';
}
