with (import ../../../rice).col; {
    urls.include = [ "*youtube.com*" ];
    urls.exclude = [ "*youtube.com" ];

    js.post = /*js*/ ''
        for (let i = 0; i < 5; i++) {
            let delay = i*500;

            setTimeout(function(){
                document.getElementById("movie_player").setVolume(0);
                console.log("ran mute after "+delay+" ms");
            }, delay);
        }
    '';

    css = /*css*/ ''
        /* remove top bar */
        div#container.style-scope.ytd-masthead,
        xxx { display: none !important; }

        /* remove sidebar */
        ytd-mini-guide-renderer,
        div#scrim.tp-yt-app-drawer,
        ytd-guide-renderer,
        xxx { display: none !important; }

        /* cleanup */
        ytd-reel-shelf-renderer, /* shorts */
        ytd-search-header-renderer, /* search filters */
        div#expandable-metadata, /* video metadata (useless) */
        div.metadata-snippet-container-one-line, /* description preview */
        div.metadata-snippet-container, /* multiline meta */
        p.style-scope, /* little badges like 4k and cc */ 
        a#channel-thumbnail, /* channel logo */
        div.badge, /* checkmark badge */
        button#button.style-scope.yt-icon-button, /* triple dot */
        xxx { display: none !important; }

        /* coloring */
        div#content,
        div#background,
        xxx {
            background: ${bg.h} !important;
        }

        yt-formatted-string, /* vid title */
        xxx { color: ${fg.h} !important; }

        a.yt-simple-endpoint, /* channel name */
        xxx { color: ${purple.h} !important; }
        div#channel-info { padding: 3px 0px !important; }

        span.inline-metadata-item, /* viewcount, publish date etc */
        p.style-scope, /* little badges like 4k and cc */ 
        xxx { color: ${t5.h} !important; }



        /* section for video (/watch*) */
        /* remove top bar */
        div#container.style-scope.ytd-masthead,
        xxx { display: none !important; }

        /* remove sidebar */
        ytd-mini-guide-renderer,
        xxx { display: none !important; }

        /* cleanup */
        ytd-reel-shelf-renderer, /* shorts */
        ytd-search-header-renderer, /* search filters */
        video.video-stream, /* the actual video */
        div.ytp-gradient-bottom, /* the bottom gradient */
        div.ytp-chrome-bottom, /* video prog bar */
        div#full-bleed-container, /* entire video container */
        div#secondary.style-scope.ytd-watch-flexy, /* watch next */
        ytd-watch-next-secondary-results-renderer, /* watch next compact */
        ytd-menu-renderer.ytd-watch-metadata, /* like/dislike stuff */
        xxx { display: none !important; }
    '';
}
