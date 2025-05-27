with (import ../../../rice).col; {
    urls.include = [ "*bessy.io*" ];
    css = /*css*/ ''
        nav.items-center,
        footer,
        xxx { display: none !important; }

        * {
            border: none !important;
            box-shadow: none !important;
        }

        div#__next,
        html {
            background: ${bg.h} !important;
        }

        :is(.dark .dark\:bg-slate-700) {
            background-color: #0000 !important;
        }

        div,
        div.box.lg,
        main#main.pb-6 {
            background: #0000 !important;
        }
    '';
}
