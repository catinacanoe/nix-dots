with (import ../../../rice).col; {
    urls.include = [ "*google.com/search*" ];
    css = /*css*/ ''
        button.HZVG1b.Tg7LZd, /* search button */
        img.lnXdpd, /* google logo */
        div.o3j99.c93Gbe, /* footer */
        center, /* im feeling lucky */
        a.MV3Tnb, /* about store */
        .gb_f, /* upper bar */
        .Gdd5U, /* google images icon */
        .goxjub, /* search with voice */
        svg, /* search icon (and more) */
        .MG7lrf, /* report innapropriate predictions */
        div.logo, /* the logo obviously */
        #result-stats, /* xxx results returned in xxx seconds */
        .oYWfcb, /* view more on yt results */
        .CvDJxb.minidiv, .Lj9fsd.DU1Mzb, /* the goofy ahhh search bar that follows u down */
        .nKHyTc, /* feedback button thing */
        .KFFQ0c .YfftMc div, /* about featured snippets */
        .fKmH1e, /* more filters */
        .ZXJQ7c, .nfSF8e, /* tools */
        .F75bid, /* safesearch */
        span.W7GCoc, /* feedback */
        div#slim_appbar, /* spacer bar at top */
        .ZFiwCf, .Bi9oQd, /* view more images */
        div.dRYYxd, /* buttons at end of search bar to make space */
        #SIvCob, /* languages */
        .gb_Oa.gb_kd, /* top bar */
        div#gb.gb_Pa.gb_ld.gb_gb.gb_i.gb_Oc.gb_vd, /* google services */
        div#tads, /* sponsored results IMPORTANT bc they crash qutebrowser */
        div[id^="tools"], /* tools button */
        div.gb_z, /* profile pic */
        xyz { display: none !important; }

        div.Bdhvof.BGBBnd {
            background: none !important;
        }

        /* search box */
        .RNNXgb:hover,
        .emcav .RNNXgb,
        .aajZCb,
        .RNNXgb {
            background: ${t1.h} !important;
            color: #cdd6f4 !important; 
            box-shadow: none !important;
            border: none !important;
        }
        /* .aajZCb { background-size: 400% !important; } */


        /* image subsearches */
        span.NQyKp,
        .REySof {
            background: #0000 !important;
        }

        .k8XOCe, /* related searches */
        .A6Smgb, /* suggested image search specifications */
        .GKS7s, /* tabs on main search page */
        .NZmxZe { /* tabs on images tab */
            background: rgba(${fg.rgb}, 0.1) !important;
            color: ${fg.h} !important;
        }
        .NZmxZe:hover {
            background: rgba(${bg.rgb}, 0.5) !important;
        }
        .rQEFy { /* current tab */
            background: rgba(${bg.rgb}, 0.8) !important;
        }

        .sbhl {
            background: rgba(${fg.rgb}, 0.1) !important;
        }

        /* link */
        a { color: ${blue.h} !important; }

        /* visited link */
        a:visited { color: ${purple.h} !important; }

        em, /* keywords */
        /* highlighted text */
        b {
            color: ${fg.h} !important;
            background: rgba(${purple.rgb}, 0.1) !important;
        }

        .gLFyf,
        input, /* search bar */
        .VuuXrf, /* search result site name */
        span { /* just general fg color */
            color: ${fg.h} !important;
        }

        .ylgVCe,
        cite { /* the link below search results */
            color: ${mg.h} !important;
        }

        /* background */
        body {
            background: ${bg.h} !important;
        }

        /* search result container */
        div {
            color: ${fg.h} !important;
            background: #0000 !important;
        }

        /* edits of content alignment */
        div.Q3DXx.Efnghe,
        xxx { display: none !important; }

        div.qogDvd, // sections
        div#center_col {
            margin-left: 10vw !important;
            width: max(400px, 50vw) !important;
        }

        div.RNNXgb { // search
            margin-left: 0vw !important;
        }

        div.RNNXgb {
        margin-right: 10vw !important;
        padding-left: 0 !important;
        max-width: 50vw !important;
        }

        div.A8SBwf {
        margin: 0 !important;
        padding: 0 !important;
        }


        /* borders are nasty */
        * {
            border: none !important;
            box-shadow: none !important;
        }
    '';
}
