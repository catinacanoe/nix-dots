{ ... }:
let
    rice = (import ../../rice);
    hostname = (import ../../ignore-hostname.nix);
    args = { inherit rice hostname; };
in {
    xdg.configFile."eww/eww.yuck".text = (import ./yuck.nix args);

    xdg.configFile."eww/eww.scss".text = (import ./scss.nix args);

    xdg.configFile."eww/init.sh".executable = true;
    xdg.configFile."eww/init.sh".text = (import ./init.nix args);
}
