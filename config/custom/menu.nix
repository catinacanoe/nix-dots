# my version of dmenu, written with 
{ pkgs, ... }:
let
    infile = "/tmp/menu-in.fifo";
    outfile = "/tmp/menu-out.fifo";
in {
    wrap = pkgs.writeShellScriptBin "menu" ''
        drop menu nohistory

        echo "$(
            # first line is reserved for flags
            if  [ "$1" == "--allow-new" ]; then
                echo "allow-new"
            else echo; fi

            # then we passthrough stdin (the list of options to choose from)
            cat
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
            args="$(echo "$input" | head -n 1)"
            list="$(echo "$input" | tail -n +2)"

            # notify-send "MENU got input" "$input"
            # echo 'testoutput' > ${outfile}
            # echo "test output" > ${outfile}

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
