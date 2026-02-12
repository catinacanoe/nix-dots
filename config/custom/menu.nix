# my version of dmenu, written with 
{ pkgs, ... }:
let
    infile = "/tmp/menu-in.fifo";
    outfile = "/tmp/menu-out.fifo";
in {
    wrap = pkgs.writeShellScriptBin "menu" ''
        # allow callers to pre-open the dropdown window,
        # because sometimes it looks too slow
        # when we open the dropdown all the way here
        if [ "$1" == "--menuui-is-open" ];
        then shift
        else drop menu nohistory; fi

        echo "$(
            echo "$1" # pass flag
            cat # pass stdin
        )" > "${infile}"

        cat "${outfile}"

        drop menu nohistory
        # hyprctl dispatch focuscurrentorlast &> /dev/null
    '';

    ui = pkgs.writeShellScriptBin "menuui" ''
        rm "${infile}" > /dev/null
        mkfifo "${infile}"

        rm "${outfile}" > /dev/null
        mkfifo "${outfile}"

        while true; do
            input="$(cat "${infile}")"
            arg="$(echo "$input" | head -n 1)"
            list="$(echo "$input" | tail -n +2)"

            if [ "$arg" == "--allow-new" ]; then
                response="$(echo "$list" | fzf --print-query)"
                selected="$(echo "$response" | tail -n 1)"
                typed="$(echo "$response" | head -n 1)"
                [ "$(echo "$response" | wc -l)" == "1" ] && selected=""

                if echo "$typed" | grep -q "\*$"; then
                    echo "$typed" | sed 's|\*$||' > "${outfile}" # a star signifies to use this input over anything else
                elif [ -z "$selected" ]; then
                    echo "$typed" > "${outfile}" # typed input is completey new
                else
                    echo "$selected" > "${outfile}" # it exists, and we prefer it always (except for "...*" case)
                fi
            elif [ "$arg" == "--print-query" ]; then
                echo "$list" | fzf --print-query > "${outfile}"
            else
                echo "$list" | fzf > "${outfile}"
            fi
        done
        '';
}
