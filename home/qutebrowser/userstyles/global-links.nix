with (import ../../../rice).col; {
    urls.include = [ "*" ];
    css = /*css*/ ''
        a { color: ${blue.h} !important; }
        a:visited { color: ${purple.h} !important; }
    '';
}
