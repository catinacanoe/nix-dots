with (import ../../../rice).col; {
    urls.include = [ "*github.com*" ];
    css = /*css*/ ''
        footer,
        xxx { display: none !important; }

        *:not(input) {
            border: none !important;
            text-shadow: none !important;
            box-shadow: none !important;
        }

        /* wallpaper */
        div,
        main,
        div#repo-content-pjax-container,
        div.application-main {
            background-color: ${bg.h} !important;
        }
        header.AppHeader {
            background: ${bg.h} !important;
        }

        :root {
            --color-fg-muted: ${mg.h} !important;
            --color-accent-fg: ${blue.h} !important;
            --color-fg-default: ${fg.h} !important;
            
            --color-primer-fg-disabled: ${mg.h} !important;
            --color-btn-counter-bg: #0000 !important;
            --color-border-default: #0000 !important;
            --color-action-list-item-default-selected-bg: ${red.h} !important;
            
            --color-btn-primary-text: ${fg.h} !important;
            --color-btn-primary-bg: rgba(var(--rrgb-fg), 0.4) !important;
            --color-btn-primary-hover-bg: rgba(var(--rrgb-fg), 0.5) !important;
            --color-btn-primary-selected-bg: rgba(var(--rrgb-fg), 0.6) !important;
            
            --color-success-fg: ${green.h} !important;
            
            --color-btn-text: ${fg.h} !important;
            --color-btn-bg: rgba(var(--rrgb-bg), 0.3) !important;
            --color-btn-hover-bg: rgba(var(--rrgb-fg), 0.1) !important;
            --color-btn-selected-bg: rgba(var(--rrgb-fg), 0.2) !important;
        }

        h1 { color: ${red.h} !important; }
        h2 { color: ${blue.h} !important; }
        h3 { color: ${purple.h} !important; }

        pre.notranslate {
            background: #0000 !important;
        }

        .btn .octicon .js-clipboard-copy-icon {
            margin-right: 0px !important;
        }

        .vhlgx,
        .hBMKRG,
        .cvGgXD,
        .hfRvxg,
        xxx { color: ${fg.h} !important; }

        .kKFNhh,
        .trpoQ,
        svg.octicon { color: ${fg.h}; }

        span { color: ${fg.h}; }

        .jMdYTc,
        .cPEOjV {
            background: var(--rwall-blur) !important;
            background-attachment: fixed !important;
            background-size: cover !important;
            border-radius: 7px !important;
        }
        .notranslate {
            background: rgba(var(--rrgb-bg), 0.3) !important;
            border-radius: 7px !important;
        }
        code {
            background: rgba(var(--rrgb-bg), 0.3) !important;
        }

        .fcmdJt { margin-right: 8px; }

        .hBMKRG:hover { background-color: var(--color-btn-primary-hover-bg) !important; }
        .hBMKRG { background-color: var(--color-btn-primary-bg) !important; }

        .fcmdJt, .vhlgx, .wxyGP { background-color: var(--color-btn-bg) !important; }
        .fcmdJt:hover, .vhlgx:hover, .wxyGP:hover { background-color: var(--color-btn-hover-bg) !important; }
    '';
}
