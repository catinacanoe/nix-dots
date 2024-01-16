{ config, ... }:
let
    home = config.home.homeDirectory;
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;

    xioxide_bin = "${config.home.sessionVariables.XIOXIDE_PATH}/main.sh";
in
with config.xdg.userDirs;
{
    # activated in the `hm` shell alias
    programs.zsh.shellAliases.xioxide="source ${xioxide_bin}";
    home.sessionVariables.XIOXIDE_PATH = "${extraConfig.XDG_REPOSITORY_DIR}/xioxide";

    xdg.configFile."xioxide/dirs.sed".text = /* sed */ ''
    s/^h/rnh/
    s/^n/rn/
    s/^o/cs/
    '';

    xdg.configFile."xioxide/dirs.conf".text = /* bash */ ''
t /
    m mnt/
r ${repos}/
    c crypt/
        r README.md
        m main.sh
        f fn/
    g gitutils/
        r README.md
        m main.sh
        f fn/
    x xioxide/
        r README.md
        m main.sh
        x xioxide.sh
        l reload.sh
    p pw/
        r README.md
        m main.sh
        f functions.sh
    n nix-dots/
        f flake.nix
        c config/
            d default.nix
            f fonts.nix
            e environment.nix
            l locale.nix
            a apps.nix
            p peripheral.nix
            s services.nix
        p private/
            m mail/
                c canoe.nix
                m marklif.nix
                s school.nix
            f firefox/firefox/main/
        r rice/
            d default.nix
            c colors/
                d default.nix
                c catppuccin.nix
                g gruvbox.nix
                r rosepine.nix
        h home/
            d default.nix
            ba bat/
                d default.nix
            cr crypt/
                d default.nix
            fi firefox/
                d default.nix
                a activate.nix
            gi git/
                d default.nix
            gu gitutils/
                d default.nix
            fu thefuck/
                d default.nix
            gp gpg/
                d default.nix
            hy hyprland/
                d default.nix
            ki kitty/
                d default.nix
            lf lf/
                d default.nix
                c colors
                s scripts/
                r run/
            ma mail/
                d default.nix
                c colors.nix
                mb gen-mbsync-gmail.nix
                mu gen-mutt-gmail.nix
            mk mako/
                d default.nix
            nv nvim/
                d default.nix
            pa pass/
                d default.nix
            po power/
                d default.nix
            pw pw/
                d default.nix
            re remap/
                d default.nix
                f fn/
                    l launch.nix
                    h hypr.nix
                m modules/
                    pe peripherals.nix
                    po power.nix
                    pr programs.nix
                    wi windows.nix
                    wo workspaces.nix
            sh shell/
                d default.nix
                p plugins/
                g modules/git.nix
            si sioyek/
                d default.nix
            st starship/
                d default.nix
            xd xdg/
                d default.nix
            xi xioxide/
                d default.nix
                a activate.nix
c ${home}/crypt/
    p pass/
        m .map
    s school/
        c czech/
        h history/
        l literature/
        m math/
            t textbook.pdf
        p physics/
            i ip/
            l l/
            r r/
            t textbook.pdf
            e equations.pdf
        r rsm/
            t textbook.pdf
        s spanish/
        t transcript.pdf
    w wiki/
    m meme/
d ${download}/
m ${music}/
v ${videos}/
p ${pictures}/
    w wall/
        d digital/
            a anime/
            b abstract/
            r art/
            p pixel/
        i irl/
            p plant/
            l landscape/
x ${documents}/
    m mail/
        c canoe/
        m marklif/
        s school/
    '';
}
