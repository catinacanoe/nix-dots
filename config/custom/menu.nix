{ pkgs, ... }:
let
    infile = "/tmp/menu-in.fifo";
    outfile = "/tmp/menu-in.fifo";
in {
    wrap = pkgs.writeShellScriptBin "menu" ''
        [ -f "${infile}" ] && rm "${infile}"
        [ -p "${infile}" ] || mkfifo "${infile}"

        [ -f "${outfile}" ] && rm "${outfile}"
        [ -p "${outfile}" ] || mkfifo "${outfile}"

        pypr show menu

        echo "$(
            if  [ "$1" == "--allow-new" ]; then
                echo "allow-new"
            else echo; fi

            cat
        )" > "${infile}"

        cat "${outfile}"

        # pypr hide menu
        hyprctl dispatch focuscurrentorlast &> /dev/null
    '';

    ui = pkgs.writeShellScriptBin "menuui" ''
        [ -f "${infile}" ] && rm "${infile}"
        [ -p "${infile}" ] || mkfifo "${infile}"

        [ -f "${outfile}" ] && rm "${outfile}"
        [ -p "${outfile}" ] || mkfifo "${outfile}"

        while true; do
            input="$(cat "${infile}")"
            args="$(echo "$input" | head -n 1)"
            list="$(echo "$input" | tail -n +2)"

            if [ "$args" == "allow-new" ]; then
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
            else
                echo "$list" | fzf > "${outfile}"
            fi
        done
        '';
}
