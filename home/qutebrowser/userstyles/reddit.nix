with (import ../../../rice).col; {
    urls.include = [ "*reddit.com*" ];
    css = /*css*/ ''
        * { border: none !important; }

        :root {
            --color-neutral-background: #0000 !important;
        }

        flex-left-nav-container,
        shreddit-dynamic-ad-link,
        div.promoted-name-container,
        div.flair-content,
        reddit-sidebar-nav,
        section#right-sidebar-container,
        comment-body-header,
        faceplate-img.shreddit-subreddit-icon__icon,
        faceplate-loader,
        header.v2,
        div.threadline,
        nav,
        span.flex,
        div[data-testid="action-row"],
        div#right-sidebar-container,
        shreddit-comment-action-row,
        xxx { display: none !important; }

        shreddit-app {
            background: ${bg.h} !important;
        }

        h1 {
            color: ${blue.h} !important;
        }

        button {
            color: ${mg.h} !important;
        }

        p,
        pre {
            color: ${fg.h} !important;
        }

        time { color: ${mg.h} !important; }

        a { color: ${blue.h} !important; }
        a:visited { color: ${purple.h} !important; }
        .text-secondary-weak, span { color: ${purple.h} !important; }

        code,
        pre,
        xxx { background: rgba(${t1.rgb}, 0.4) !important; }

        .bg-neutral-background { background-color: #0000 !important; }
        shreddit-post,
        shreddit-comment-tree {
            background: #0000 !important;
            color: ${fg.h} !important;
            border-radius: 10px !important;
        }

        main#main-content {
            margin: 0 0 !important;
        }

        div[data-testid="action-row"],
        div.shreddit-post-container {
            display: none !important;
        }

        img { border-radius: 7px !important; }
    '';
}
