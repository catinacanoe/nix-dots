let
    files = map (basename: ./userstyles + "/${basename}") (builtins.attrNames (builtins.readDir ./userstyles));

    # function takes a filepath to a .nix that evaluates to an attrset with css and js info
    # returns a attrset with name and value for xdg.configFile of a greasemonkey script using the data passed in
    composeJavascript = file: let
        name = builtins.elemAt (builtins.match "^(.*)\\.nix$" (builtins.baseNameOf file)) 0;
    in {
        name = "qutebrowser/greasemonkey/style-${name}.js";

        value = let attrs = import file; in {
            text = /*js*/ ''
                // ==UserScript==
                // @name ${name} userstyle
                ${if attrs?urls.include then builtins.concatStringsSep "\n" (map (url: "// @include ${url}") attrs.urls.include) else ""}
                ${if attrs?urls.exclude then builtins.concatStringsSep "\n" (map (url: "// @exclude ${url}") attrs.urls.exclude) else ""}
                // ==/UserScript==

                console.log("userstyle for ${name} starting load");
                ${if attrs?js.pre then attrs.js.pre else ""}
                GM_addStyle(`
                ${if attrs?css then attrs.css else ""}
                `)
                ${if attrs?js.post then attrs.js.post else ""}
                console.log("userstyle for ${name} finished load");
            '';
        };
    };
in builtins.listToAttrs (map composeJavascript files)

# i'm honestly super proud of this file
# its my first time actually using nix as a full language
# rather than just as a config language like toml
# i think its super cool
