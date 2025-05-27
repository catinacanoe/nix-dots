{ pkgs, ... }:
let
    files = map (basename: ./userstyles + "/${basename}") (builtins.attrNames (builtins.readDir ./userstyles));

    # function takes a filepath to a .nix that evaluates to an attrset with css and js info
    # returns a attrset with name and value for xdg.configFile of a greasemonkey script using the data passed in
    composeJavascript = file: let
        name = builtins.elemAt (builtins.match "^(.*)\\.nix$" (builtins.baseNameOf file)) 0;
    in {
        name = "qutebrowser/greasemonkey/style-${name}.js";

        value = let attrs = import file; in {
            onChange = "$DRY_RUN_CMD ${pkgs.qutebrowser}/bin/qutebrowser ':greasemonkey-reload'";
            text = /*js*/ ''
                // ==UserScript==
                // @name ${name} userstyle
                ${if attrs?urls.include then builtins.concatStringsSep "\n" (map (url: "// @include ${url}") attrs.urls.include) else ""}
                ${if attrs?urls.exclude then builtins.concatStringsSep "\n" (map (url: "// @exclude ${url}") attrs.urls.exclude) else ""}
                // ==/UserScript==

                ${if attrs?js.pre then attrs.js.pre else ""}
                GM_addStyle(`
                ${if attrs?css then attrs.css else ""}
                `)
                ${if attrs?js.post then attrs.js.post else ""}
            '';
        };
    };
in builtins.listToAttrs (map composeJavascript files)
