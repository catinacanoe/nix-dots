with (import ../../../rice).col; {
    urls.include = [
        "*stackoverflow.com*"
        "*stackexchange.com*"
        "*superuser.com*"
        "*askubuntu.com*"
    ];
    css = /*css*/ ''
        div.js-bottom-notice,
        div.mt16,
        div#left-sidebar,
        div#sidebar,
        a.ws-nowrap.s-btn.s-btn__filled,
        .left-sidebar--sticky-container,
        button.js-vote-down-btn,
        button.js-vote-up-btn,
        blockquote::before,
        div.site-footer--container,
        div.d-flex.g4.gsx.ai-center,
        a.js-add-link.comments-link,
        div.user-info,
        form#post-form,
        div.js-post-menu,
        svg.js-saves-btn-unselected,
        a.js-post-issue,
        h2.bottom-notice,
        div.snippet-ctas
        { display: none !important; }

        div.js-vote-count {
            font-size: 25px !important;
        }
        a.question-hyperlink,
        h2.mb0 {
            font-size: 40px !important;
        }

        body {
            background: ${bg.h} !important;
        }
        div#content { background: #0000 !important; }

        /* topbar */
        header,
        div.s-topbar--container {
            display: none !important;
        }

        /* remove separator bar under question */
        .bc-black-200 {
            border-color: #0000 !important;
        }

        /* MG COL */
        .mr2,
        div.flex--item.ws-nowrap.mb8,
        h2.bottom-notice,
        time,
        div.d-flex {
            color: ${mg.h} !important;
        }
        /* FG COL */
        span,
        body,
        .fc-theme-body-font,
        code,
        kbd,
        div,
        select,
        pre,
        p {
            color: ${fg.h} !important;
        }

        /* DARK BG */
        code,
        textarea,
        div.user-info,
        div.user-info.user-hover,
        div.post-signature,
        a.post-tag,
        aside,
        select,
        pre
        { background: ${t1.h} !important; } // bg

        /* LIGHT BG */
        span.flex--item,
        a.comment-user,
        a.post-tag,
        kbd,
        .s-btn.s-btn__filled
        {
            background: rgba(${fg.rgb}, 0.1) !important; // fg
        }

        img {
            border-radius: 7px !important;
        }
        kbd {
            text-shadow: none !important;
            box-shadow: none !important;
        }

        button:hover, .s-btn:hover {
            color: ${mg.h} !important;
        }

        h1,
        h2 {
        color: ${purple.h} !important;
            background: rgba(${purple.rgb}, 0.2) !important;
            padding-right: 0px !important;
            padding-left: 0.5em !important;
            border-radius: 7px !important;
        }

        div.js-vote-count
        { color: ${red.h} !important; }

        .s-btn { /* buttons */
            color: ${fg.h} !important;
        }

        svg.svg-icon.iconCheckmarkLg { /* accepted ans check */
            color: ${green.h} !important;
        }

        .s-popover { /* hover tooltip */
            background: rgba(${bg.rgb}, 0.7) !important; // bg
        }

        * { border: none !important; }
    '';
}
