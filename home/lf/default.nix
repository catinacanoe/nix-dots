{ config, pkgs, ... }:
let
    lfdir = "${config.xdg.configHome}/lf";
in
let
    scriptdir = "${lfdir}/scripts";
in
{
    xdg.configFile."lf/colors".source = ./colors;
    xdg.configFile."lf/scripts" = {
        source = ./scripts;
	recursive = true;
    };

    programs.zsh.shellAliases.a = "lf";

    # maybe readd typetonav
    programs.lf =
    {
        enable = true;
	settings = 
        let
            cursor = ''\033[3m\033[1m>'';
	    bold = ''\033[1m'';
	    italic = ''\033[3m'';
	    inverse = ''\033[7m'';
        in
        {
	    shell = "zsh";
	    hidden = true;
	    ignorecase = true;
	    icons = false;
	    ifs = ''\n'';
	    scrolloff = 7;
	    tabstop = 4;
	    cursorpreviewfmt = "${bold+italic}>";
	    cursorparentfmt = "${bold+italic}>";
	    cursoractivefmt = "${bold+italic+inverse}";
	    previewer = "${scriptdir}/previewer";
	};
	commands = {
	    custom_open = ''%${scriptdir}/opener'';
	    custom_wall = ''%swww img "$f"'';

	    custom_mkdir = ''%{{
                printf " dir name: "
                read ans
                mkdir -p "$ans"
	    }}'';

	    custom_touch = ''%{{
                printf " file name: "
                read ans
                touch "$ans"
		echo -e '\n' > "$ans"
	    }}'';

            custom_chmod = ''%{{
	        printf " chmod bits: "
		read ans
		for file in "$fx"; do
		    chmod "$ans" "$file"
		done
	    }}'';

	    custom_drag = ''%{{
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
	    ''%{{
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
	    # drag and drop
	    "<left>" = null;
	    "<up>" = null;
	    "<down>" = null;
	    "<right>" = null;
	    "q" = null;
	    "f" = null;
	    "h" = null;
	    "v" = null;
	    "e" = null;
	    "x" = null;

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
	    "<c-d>" = "custom_drag";
	};
    };
}
