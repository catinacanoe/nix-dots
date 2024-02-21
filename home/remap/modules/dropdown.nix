{ mod, ... }:
let
    launch = (import ../fn/launch.nix);
    drop = name: launch "drop ${name}";
in
/* yaml */ ''
# dropdown.nix
        ${mod}-dot:
            remap:
                ${mod}-w:
                    ${launch "drop"}
                    
                ${mod}-t:
                    ${drop "term"}
                ${mod}-p:
                    ${drop "top"}
                ${mod}-s:
                    ${drop "news"}
                ${mod}-m:
                    ${drop "network"}
                ${mod}-v:
                    ${drop "vpn"}
                ${mod}-n:
                    ${drop "nix"}
                ${mod}-q:
                    ${drop "qalc"}
                ${mod}-b:
                    ${drop "bluetooth"}

                ${mod}-h:
                    ${drop "browser"}
                ${mod}-g:
                    ${drop "gpt"}
        ${mod}-w:
            ${launch "pypr toggle browseshell"}
# dropdown.nix
''
