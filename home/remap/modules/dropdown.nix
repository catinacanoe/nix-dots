{ mod, ... }:
let
    launch = (import ../fn/launch.nix);
    drop = name: launch "drop ${name}";
in
/* yaml */ ''
# dropdown.nix
        ${mod}-dot:
            remap:
                ${mod}-t:
                    ${launch "drop"}
                ${mod}-t:
                    ${drop "term"}
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
                ${mod}-d:
                    ${drop "discord"}
        ${mod}-w:
            ${drop "browsepad"}
# dropdown.nix
''
