with (import ../../../rice).col; {
    urls.include = [ "*mynixos.com*" ];
    css = /*css*/ ''
        * {
            border: none !important;
            box-shadow: none !important;
        }

        /* REMOVED ELEMENTS */
        .buMiCr, /* homepage logo */
        .jNJPKD, /* signin */
        .QjOYn, /* header tabs */
        .bidFJn, /* slash icon in search */
        svg.sc-eBMEME, svg.sc-eONNys, /* search icon */
        footer, /* i wonder */
        div.Box-sc-g0xbh4-0.lfXbtX, /* searhc in n options and n packages across n categories */
        .eRLFav, /* homepage content */
        .eqISNM, /* videos on homepage */
        .dOGtcq, /* matched n out of n entries in n seconds */
        div[class^="Flash__StyledFlash"], /* sign in prompt */
        xxx { display: none !important; }

        div.sc-78c9f83-0.cSoZLt {
            background: ${t1.h} !important;
            input { color: ${fg.h} !important; }
        }

        div,
        div[class^="Box"],
        div.infinite-scroll-component,
        header {
            background: ${bg.h} !important;
        }

        span,
        xxx { color: ${mg.h} !important; }

        .jWwop, /* build and share reproducible etc etc homepage */
        xxx { color: ${purple.h} !important; }

        h1,
        div,
        .bEgCIk,
        input,
        xxx { color: ${fg.h} !important; }

        /* TRANSPARENT BG */
        .eVSYsD,
        .dnVZYK,
        xxx { background: #0000 !important; }

        /* DARK BG */
        pre,
        xxx { background: ${t1.h} !important; }

        /* LIGHT BG */
        button,
        em,
        xxx { background: ${t2.h} !important; }

        /* LINKS */
        a { color: ${blue.h} !important; }
        a:visited { color: ${purple.h} !important; }
    '';
}
