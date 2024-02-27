{ ... }:
let
    rice = (import ../../rice);
    hostname = (import ../../ignore-hostname.nix);
    args = { inherit rice hostname; };
in {
    xdg.configFile."eww/eww.yuck".text = (import ./yuck.nix args);

    xdg.configFile."eww/eww.scss".text = (import ./scss.nix args);

    xdg.configFile."eww/script/battery.sh".executable = true;
    xdg.configFile."eww/script/battery.sh".text = (import ./script/battery.nix);

    xdg.configFile."eww/script/workspaces.sh".executable = true;
    xdg.configFile."eww/script/workspaces.sh".text = (import ./script/workspaces.nix);

    xdg.configFile."eww/script/active.sh".executable = true;
    xdg.configFile."eww/script/active.sh".text = (import ./script/active.nix);

    xdg.configFile."eww/script/init.sh".executable = true;
    xdg.configFile."eww/script/init.sh".text = (import ./script/init.nix);
}
