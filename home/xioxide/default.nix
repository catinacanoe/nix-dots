{ config, pkgs, inputs, ... }:
let
    home = config.home.homeDirectory;
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;

    lib = inputs.home-manager.lib;
    xioxide_bin = "${config.home.sessionVariables.XIOXIDE_PATH}/main.sh";
in
with config.xdg.userDirs;
{
    programs.bash.shellAliases.xioxide="source ${xioxide_bin}";
    home.sessionVariables.XIOXIDE_PATH = "${extraConfig.XDG_REPOSITORY_DIR}/xioxide";
    home.activation.xioxide = lib.hm.dag.entryAfter ["writeBoundary"]
        "echo 'recommend running `xioxide reload`'";

    xdg.configFile."xioxide/dirs.conf".text = ''
t /
    m mnt/
r ${repos}/
    x xioxide/
        r README.md
        m main.sh
        x xioxide.sh
        l reload.sh
    p pw/
        r README.md
        m man.txt
        d default.sh
        f functions.sh
n ${repos}/nix-dots/
    h home/
        d default.nix
        gi git/
            d default.nix
        gp gpg/
            d default.nix
        hy hyprland/
            d default.nix
        ki kitty/
            d default.nix
        mb mbsync/
            d default.nix
        nm neomutt/
            d default.nix
        nv nvim/
            d default.nix
        pa pass/
            d default.nix
        pw pw/
            d default.nix
        sh shell/
            d default.nix
        xd xdg/
            d default.nix
        xi xioxide/
            d default.nix
        xr xremap/
            d default.nix
	    f fn/
	    m modules/
    c config/
        d default.nix
        f fonts.nix
        e environment.nix
        l locale.nix
        a apps.nix
        p peripheral.nix
        s services.nix
    i ignore/
        m mbsynrc
        h hardware-config.nix
    r rice/
        d default.nix
        c colors/
        d default.nix
            c catppuccin.nix
            g gruvbox.nix
            r rosepine.nix
c ${home}/crypt/
    p pass/
        m .map
d ${download}/
p ${pictures}/
    w wall/
x ${documents}/
    m mail/
        c canoe/
        m marklif/
    '';
}
