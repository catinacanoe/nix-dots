{ config, ... }:
let
    lfdir = "${config.xdg.configHome}/lf";
    scriptdir = "${lfdir}/scripts";
    home = config.home.homeDirectory;
in
{
    xdg.configFile."lf/colors".source = ./colors;
    xdg.configFile."lf/scripts/previewer".source = ./scripts/previewer;
    xdg.configFile."lf/scripts/opener"= {
        executable = true;
        text = (import ./scripts/opener.nix { inherit config; });
    };

    programs.zsh.initExtra = /* bash */ ''
    lfcd() {
        tmp="$(mktemp -uq)"
        trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
        lf -last-dir-path="$tmp" "$@"
        if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
        fi
    }
    '';

    # maybe re-add typetonav
    programs.lf =
    {
        enable = true;

        settings = 
        let
            bold = ''\033[1m'';
            italic = ''\033[3m'';
            inverse = ''\033[7m'';

            red = ''\033[31m'';
            green = ''\033[32m'';
            yellow = ''\033[33m'';
            blue = ''\033[34m'';
            purple = ''\033[35m'';
            aqua = ''\033[36m'';
            fg = ''\033[37m'';
            mg = ''\033[2;37m'';
            na = ''\033[0m'';
        in
        {
            shell = "zsh";
            hidden = true;
            ignorecase = true;
            ifs = ''\n'';
            scrolloff = 3;
            tabstop = 4;
            cursorpreviewfmt = "${bold+italic}>";
            cursorparentfmt = "${bold+italic}>";
            cursoractivefmt = "${bold+italic+inverse}";
            errorfmt = ''${red+italic}'';
            previewer = "${scriptdir}/previewer";
            promptfmt = ''${purple+italic}%d%f${na}'';
            dupfilefmt = ''%f.%n'';
            rulerfmt = ''${mg}%a${na}  |${mg}%p${na}  |\033[7;31m %m ${na}  |\033[7;33m %c ${na}  |\033[7;35m %s ${na}  |\033[7;34m %f ${na}  |${mg+italic} %i / %t${na}'';
            statfmt = ''${aqua+italic}%p${na}| ${green+italic}%u:%g${na}| ${red+italic}%s${na}| ${mg+italic}%t${na}| ${aqua}-> %l${na}'';
            timefmt = ''02.01.2006 @ 15:04'';
            incsearch = true;
            ratios = [ 1 2 3 ];
        };

        commands = 
        let
            inherit (config.programs.zsh.shellAliases) xioxide;
            xioxide_fn = ''[ "$1" == "$HOME" ] && return || return 1'';
        in
        {
            custom_open = ''%${scriptdir}/opener'';
            custom_wall = ''%wpp desktop "$f"'';
            custom_fullwall = ''$wpp browser "$f" && echo -n "press enter" && read'';

            custom_extract = /* bash */ ''%{{
                if [ -f "$f" ] ; then
                    case "$f" in
                        *.tar.bz2) tar xjf    "$f" ;;
                        *.tar.gz)  tar xzf    "$f" ;;
                        *.bz2)     bunzip2    "$f" ;;
                        *.rar)     unrar x    "$f" ;;
                        *.gz)      gunzip     "$f" ;;
                        *.tar)     tar xf     "$f" ;;
                        *.tbz2)    tar xjf    "$f" ;;
                        *.tgz)     tar xzf    "$f" ;;
                        *.zip)     unzip      "$f" ;;
                        *.Z)       uncompress "$f" ;;
                        *.7z)      7z x       "$f" ;;
                        *)         echo "'$f' cannot be extracted via ex()" ;;
                    esac
                else
                    echo "'$f' is not a valid file"
                fi
            }}'';

            custom_ee = "cd ~";
            custom_eo = /* bash */ ''%lf -remote "send $id cd \"$OLDPWD\""'';
            custom_e = /* bash */ ''%{{
                printf " e "
                read ans
                target="$(${xioxide} "" "grep '/$'" pwd '${xioxide_fn}' dirs $ans)"
                lf --remote "send $id cd \"$target\""
            }}'';
            custom_h = /* bash */ ''%{{
                printf " h "
                read ans
                target="$(${xioxide} "" "grep -v '/$'" pwd '${xioxide_fn}' dirs $ans)"
                lf --remote "send $id \$$EDITOR \"$target\""
            }}'';

            custom_mkdir = /* bash */ ''%{{
                printf " dir name: "
                read ans
                mkdir -p "$ans"
            }}'';

            custom_touch = /* bash */ ''%{{
                printf " file name: "
                read ans
                touch "$ans"
                echo -e '\n' > "$ans"
            }}'';

            custom_chmod = /* bash */ ''%{{
                printf " chmod bits: "
                read ans
                for file in "$fx"; do
                    chmod "$ans" "$file"
                done
                lf -remote 'send reload'
            }}'';

            custom_drag = /* bash */ ''%{{
                num="$(echo "$fx" | wc -l)"

                if [ "$num" = "1" ]; then
                    dragon -T -x "$f" &
                else
                    dragon -T -a -x "$fx" &
                fi
            }}'';

            custom_trash =
            let
                file = "\${files%%;*}";
                files = "\${files#*;}";
            in
            /* bash */ ''%{{
                files=$(printf "$fx" | tr '\n' ';')
                while [ "$files" ]; do
                    file=${file}

                    trash-put "$(basename "$file")"
                    if [ "$files" = "$file" ]; then
                        files=""
                    else
                        files="${files}"
                    fi
                done
            }}'';
        };

        keybindings = {
            "<left>" = null;
            "<up>" = null;
            "<down>" = null;
            "<right>" = null;
            "q" = null;
            "f" = null;
            "v" = null;
            "e" = null;
            "h" = null;

            "e<enter>" = "custom_ee";
            "eo" = "custom_eo";
            "e<space>" = "custom_e";
            "h<space>" = "custom_h";

            "<c-r>" = "reload";
            ";" = "quit";
            "n" = "updir";
            "a" = "up";
            "i" = "down";
            "o" = "custom_open";

            "/" = "search";
            "j" = "search-next";
            "J" = "search-prev";

            "k" = "custom_mkdir";
            "m" = "rename";
            "l" = "custom_touch";

            "r" = "custom_trash";
            "u" = "$trash-restore";

            "c" = "custom_chmod";
            "." = "set hidden!";
            "w" = "custom_wall";
            "W" = "custom_fullwall";
            "x" = "custom_extract";
            "<c-d>" = "custom_drag";
        };
    };
}
