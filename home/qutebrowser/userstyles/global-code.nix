with (import ../../../rice).col; {
    urls.include = [ "*" ];
    css = /*css*/ ''
        code.hljs { background: #0000 !important; }

        span.hljs-built_in,
        span.hljs-name,
        span.hljs-selector-pseudo,
        xxx { color: ${red.h} !important; }

        span.hljs-literal,
        xxx { color: ${orange.h} !important; }

        span.hljs-keyword,
        span.hljs-type,
        span.hljs-function,
        span.hljs-attribute,
        span.hljs-attr,
        span.hljs-selector-attr,
        xxx { color: ${yellow.h} !important; }

        span.hljs-string,
        xxx { color: ${green.h} !important; }

        span.hljs-selector-class,
        xxx { color: ${aqua.h} !important; }

        span.hljs-number,
        xxx { color: ${blue.h} !important; }

        span.hljs-variable,
        span.hljs-title,
        xxx { color: ${purple.h} !important; }

        span.hljs-meta,
        span.hljs-comment,
        xxx { color: ${mg.h} !important; }
    '';
}
