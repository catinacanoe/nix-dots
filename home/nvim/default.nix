# https://discourse.nixos.org/t/neovim-and-nixos-star-crossed-lovers/25568/15
# https://github.com/collinarnett/brew/blob/0169cc473d781352e8418660d1b20a2c30c2e84c/modules/home-manager/neovim/neovim.nix
{ config, pkgs, ... }:
let
    col = (import ../../rice).col;
in {
    programs.neovim = {
        enable = true;
	defaultEditor = true;
	plugins = with pkgs; [
	    (import ./gruvbox.nix vimPlugins col)
	];
    };
}









