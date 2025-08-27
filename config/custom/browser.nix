{ pkgs, ... }: pkgs.writeShellScriptBin "browser" ''
case "$1" in
    "new-window")
        case "$BROWSER" in
            "org.qutebrowser.qutebrowser") qutebrowser ;;
            "firefox") firefox -P main --new-window ;;
        esac
        ;;
    "new-tab")
        case "$BROWSER" in
            "org.qutebrowser.qutebrowser") qutebrowser ":open -t $2" &>/dev/null ;;
            "firefox") 
                if [ "$(hyprctl activewindow -j | jq .class)" == '"firefox"' ]; then
                    wl-copy "$2"
                    wtype -M ctrl -k t -m ctrl
                    sleep 0.15
                    wtype -M ctrl -k v -m ctrl
                    sleep 0.15
                    wtype -k Return
                fi
            ;;
        esac
        ;;
    "get-url")
        case "$BROWSER" in
            "org.qutebrowser.qutebrowser") cat /tmp/qute_url ;;
            "firefox") 
                if [ "$(hyprctl activewindow -j | jq .class)" == '"firefox"' ]; then
                    wtype -M ctrl -k l -m ctrl
                    sleep 0.15
                    wtype -M ctrl -k c -m ctrl
                    sleep 0.15
                    wl-paste
                fi
            ;;
        esac
        ;;
    "help")
        echo "help page for `browser`, a general interface for browsers"
        echo
        echo "new-window"
        echo "    opens a new empty window"
        echo
        echo "new-tab"
        echo "    opens the url passed in a new tab"
        echo
        echo "get-url"
        echo "    prints the url of the currently open page"
        echo
        ;;
esac
''
