with (import ../../../rice).col; {
    urls.include = [ "*nixos.org*" ];
    css = /*css*/ ''
        div#menu-bar,
        div.info::before,
        xxx { display: none !important; }

        nav#sidebar {
            background: ${t1.h} !important;
        }

        div.page {
            background: ${bg.h} !important;
        }

        a.header {
            color: ${blue.h} !important;
        }

        span.language-bash,
        p {
            color: ${fg.h} !important;
        }

        code.hljs.language-undefined,
        code.language-console {
            background: rgba(${t1.rgb}, 0.5) !important;
            border-radius: 5px !important;
            color: ${fg.h} !important;
        }

        div.info {
            p { color: ${yellow.h} !important; }
            border: none !important;
        }
    '';
}
