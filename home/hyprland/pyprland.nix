{ config, pkgs, ... }:
{
    activation = "$DRY_RUN_CMD ${pkgs.pyprland}/bin/pypr reload > /dev/null";

    pypr = let
        sizes = let
            size = width: height: /* toml */ ''
                size = "${toString width}% ${toString height}%"
                position = "${toString ((100 - width) / 2)}% ${toString ((100 - height) / 2)}%"
            '';
        in {
            default = size 70 70;
            mini = size 30 10;
        };

        pad = { name, command, lazy, size?sizes.default }: /*toml*/ ''
            [scratchpads.${name}]
            command = "${command}"
            lazy = ${if lazy then "true" else "false"}
            ${size}
        '';

        term_pad = { name, shellscript, lazy?false, size?sizes.default }: pad {
            inherit name lazy size;
            command = "${config.home.sessionVariables.TERMINAL} --class scratchpad ${shellscript}";
        };

        # TODO make the browserpad actually work with qutebrowser
        browser_pad = { name, url, lazy?true, size?sizes.default  }: pad {
            inherit name lazy size;
            command = "browser new-tab ${url}";
        };
    in {
        text = /*toml*/ ''
            [pyprland]
            plugins = [ "scratchpads" ]

            # remember to add a keybind to ../remap/modules/dropdown.nix
            ${term_pad { name = "term";        shellscript = ""; }}
            ${term_pad { name = "network";     shellscript = "sudo netshell"; }}
            ${term_pad { name = "nix";         shellscript = "nixshell"; }}
            ${term_pad { name = "menu";        shellscript = "menuui"; }}
            ${term_pad { name = "browseshell"; shellscript = "browseshell"; }}
            ${term_pad { name = "news";        shellscript = "newsboat"; }}
            ${term_pad { name = "mtag";        shellscript = "mustagger"; }}
            ${term_pad { name = "player";      shellscript = "player"; }}
            ${term_pad { name = "qalc";        shellscript = "qalc"; }}
            ${term_pad { name = "bluetooth";   shellscript = "blueshell"; }}
            ${term_pad { name = "gpgpass";     shellscript = "$XDG_REPOSITORY_DIR/pw/unlock.sh"; size = sizes.mini; }}
            ${term_pad { name = "top";         shellscript = "gotop"; lazy = true; }}

            ${browser_pad { name = "browser";  url = "about:blank"; }}
            ${browser_pad { name = "calendar"; url = "calendar.google.com"; }}
            ${browser_pad { name = "gpt";      url = "chatgpt.com"; }}

            ${pad { name = "spotify"; command = "spotify"; lazy = true; }}
        '';
    };
}

