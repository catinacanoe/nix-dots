{ config, ... }:
let
    home = config.home.homeDirectory;
    repos = config.xdg.userDirs.extraConfig.XDG_REPOSITORY_DIR;
in
with config.xdg.userDirs;
{
    # activated in the `hm` shell alias
    programs.zsh.shellAliases.xioxide="source ${repos}/xioxide/main.sh";
    home.sessionVariables.XIOXIDE_PATH = "${extraConfig.XDG_REPOSITORY_DIR}/xioxide";

    xdg.configFile."xioxide/sites.conf".text = (import ./sites.nix).conf;

    xdg.configFile."xioxide/dirs.sed".text = /* sed */ ''
    s/^h/rnh/
    s/^n/rn/
    s/^o/xs/
    s/^w/xw/
    '';

    xdg.configFile."xioxide/dirs.conf".text = /* bash */ ''
t /
    m mnt/
r ${repos}/
    c cadence/
        s src/
        d dox/
        r run/
        n shell.nix
    y crypt/
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
            c custom/
                br browse.nix
                bs browseshell.nix
                dr drop.nix
                hy hypr.nix
                la launcher.nix
                ma manpager.nix
                me menu.nix
                mp mptoggle.nix
                ms netshell.nix
                mu mustagger.nix
                ns nixshell.nix
                pl player.nix
                sb setbright.nix
                ss sshkey.nix
                sv setvol.nix
                vs vpnshell.nix
                ya yargs.nix
            d default.nix
            b boot.nix
            f fonts.nix
            e environment.nix
            l locale.nix
            a apps.nix
            p peripheral.nix
            s services.nix
            i ignore-hardware.nix
            h hardware.nix
        p private/
            m mail/
                c canoe.nix
                m marklif.nix
                s school.nix
            f firefox/firefox/main/
        r rice/
            d default.nix
            w wall/
                d default.nix
            c colors/
                d default.nix
                c out/catppuccin.nix
                g out/gruvbox.nix
                r out/rosepine.nix
        h home/
            d default.nix
            ba bat/
                d default.nix
            ca cava/
                d default.nix
            cr crypt/
                d default.nix
            di discord/
                d default.nix
                a activate.nix
            dy dye/
                d default.nix
            ew eww/
                i init.nix
                d default.nix
                y yuck.yuck
                yn yuck.nix
                c scss.nix
            fi firefox/
                d default.nix
                a activate.nix
            fz fzf/
                d default.nix
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
                p pyprland.nix
                ih ignore-hypr.nix
                ip ignore-pypr.nix
            ki kitty/
                d default.nix
            im imv/
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
            md mpd/
                d default.nix
            mv mpv/
                d default.nix
            mk mako/
                d default.nix
            ne newsboat/
                d default.nix
            nv nvim/
                d default.nix
            pa pass/
                d default.nix
            po power/
                d default.nix
            pw pw/
                d default.nix
            qb qutebrowser/
                d default.nix
                b binds.nix
                c colors.nix
                o options.nix
                u userstyles/
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
            sc scrot/
                d default.nix
            sh shell/
                d default.nix
                p plugins/
                g modules/git.nix
            si sioyek/
                d default.nix
            sp spicetify/
                d default.nix
            st starship/
                d default.nix
            wp wpp/
                d default.nix
            xd xdg/
                d default.nix
            xi xioxide/
                d default.nix
                a activate.nix
                s sites.nix
s ${config.programs.password-store.settings.PASSWORD_STORE_DIR}/
    m .map
d ${download}/
m ${music}/
    i .index
    s songs/
    d dl/
v ${videos}/
    m mnt/
    c cache/
p ${pictures}/
    t troll/
    g grim/
    w wall/
        n index
        d digital/
            b abstract/
            a anime/
            f focus/
            l landscape/
            n nature/
            p pixel/
            s sky/
        i irl/
            a animals/
            f food/
            l landscape/
            p plant/
            s sky/
            v vehicle/
x ${documents}/
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
        l calendar.pdf
    w wiki/
        e engineering/
        g gamedev/
        j journal/
            d day.norg
            m month.norg
            g goals.norg
        l learning/
            c czech.norg
            o food.norg
            h history.norg
            k kaizen.norg
            l learning.norg
            p piano.norg
            t trading.norg
        f life/
            b birthdays.norg
            d dental.norg
            l drivers-license.norg
            o other.norg
            r room.norg
            v vehicles.norg
        x linux/
        o school/
            i .index.norg
            c .chem.norg
            h .gov.norg
            m .stats.norg
            a .avid.norg
            s .spanish.norg
            l .literature.norg
            r .rsm.norg
            o .other.norg
            p other-posthigh.norg
        s softwaredev/
        y style/
            i .index.norg
            h head.norg
        w work/
            a airborne.norg
            r rsm.norg
            s selling.norg
        f fitness/
        i .index.norg
    i important/
    m mail/
        c canoe/
        m marklif/
        s school/
    '';
}
