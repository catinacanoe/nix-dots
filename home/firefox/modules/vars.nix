rice:
let
    col = rice.col;
in
let
    define = name: ''
                --rcol-${name}: ${col."${name}".h};
                --rrgb-${name}: ${col."${name}".rgb};
    '';
in
''
            --rwall: url("${rice.wall.url}");
            --rwall-blur: url("${rice.wall.url-blur}");
            --rwall-dim: url("${rice.wall.url-dim}");

            ${define "bg"}
            ${define "mg"}
            ${define "fg"}

            ${define "t0"}
            ${define "t1"}
            ${define "t2"}
            ${define "t3"}
            ${define "t4"}
            ${define "t5"}
            ${define "t6"}
            ${define "t7"}

            ${define "red"}
            ${define "orange"}
            ${define "yellow"}
            ${define "green"}
            ${define "aqua"}
            ${define "blue"}
            ${define "purple"}
            ${define "brown"}
''
