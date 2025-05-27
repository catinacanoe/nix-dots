{
    urls.include = [ "*" ];
    urls.exclude = [ "*tasks.google.com*" ];
    css = /*css*/ ''
        textarea, body, p, a, div, span, h1, h2, h3, h4, h5, h6, li, td, th, code, pre {
            font-family: monospace, sans-serif !important;
        }

        .material-icons, .icon, [class*="icon"] {
            font-family: initial !important;
        }
    '';
}
