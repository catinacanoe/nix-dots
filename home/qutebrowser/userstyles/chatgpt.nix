with (import ../../../rice).col; {
    urls.include = [ "*chatgpt.com*" ];
    css = '''';


    NOTcss = /*css*/ ''
        * {
            border: none !important;
            box-shadow: none !important;
        }

        div#page-header,
        div.bg-token-bg-elevated-secondary,
        div.text-token-text-secondary,
        xxx { display: none !important; }

        /* sidebar */
        nav[aria-label="Chat history"],
        div#sidebar-header,
        xxx {
            background: ${t1.h} !important;
            color: ${fg.h} !important;
            h2 {
                color: ${mg.h} !important;
            }
        }

        /* user input */
        div.relative.bg-token-message-surface,
        div.whitespace-pre-wrap,
        div.flex.w-full.cursor-text.flex-col.items-center,
        xxx {
            background: ${t1.h} !important;
            color: ${fg.h} !important;
            p { color: ${fg.h} !important; }
            p.placeholder { color: ${mg.h} !important; }
        }

        /* chat */
        div.relative.h-full,
        div.text-base,
        article,
        xxx {
            background: ${bg.h} !important;
            color: ${fg.h} !important;

            strong { color: ${fg.h}; }
            p, h4 { color: ${fg.h} !important; }
            h3 { color: ${blue.h} !important; }
            h3 strong { color: ${blue.h} !important; }
            code:not([class]) {
                color: ${fg.h} !important;
                background: rgba(${t1.rgb}, 0.4) !important;
            }
            div.contain-inline-size {
                background: rgba(${t1.rgb}, 0.4) !important;
            }
        }
    '';
}
