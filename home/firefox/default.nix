{ ... }:
let 
    prefix = "repos/nix-dots/private/firefox-main";
    rice = (import ../../rice);
in
{
    home.file."${prefix}/chrome/userContent.css".text = ''
        :root {
            ${import ./modules/vars.nix rice}
        }

        * { font-family: monospace !important; }
    '';

    home.file."${prefix}/chrome/userChrome.css".text = ''
        :root {
            ${import ./modules/vars.nix rice}

            --navbarWidth: 100vw;
            --focus-outline-color: transparent !important;

            --lwt-toolbar-field-highlight: var(--rcol-t2) !important;
        }

        browser#webext-panels-browser {
            background-image: var(--rwall-blur);
        }

        html|input.findbar-textbox::placeholder,
        .browserContainer > findbar {
            background: var(--rcol-bg) !important;
            color: var(--rcol-fg) !important;
        }

        #sidebar-box > #browser,
        #webextpanels-window{
            background: #0000 !important
        }
        
        /* right click and other menus */
        menu, menuitem, panel, menupopup {
            color-scheme: dark !important;
            color: var(--rcol-fg) !important;
            border: none !important;
        }
        
        menupopup, panel {
            &::part(content) {
                color: var(--rcol-fg) !important;
                background: var(--rcol-bg) !important;
                border: none !important;
            }
        }

        menu, menuitem {
            &:where([_moz-menuactive]:not([disabled="true"])) {
                color: var(--rcol-purple) !important;
                background-color: var(--rcol-t1) !important;
            }
        }

        #main-window { background: #0000 !important; }

        .panel-header { color: var(--rcol-fg) !important; }

        /* just the buttons on toolbar */
        toolbarbutton { color: var(--rcol-fg) !important; }

        #urlbar-results {
            display: none; !important
        }

        #urlbar-input-container, .urlbarView {
            background: #0000 !important;
            position: absolute !important; /* prevent text from moving when focsed */
        }

        #urlbar::-moz-selection,
        *::-moz-selection,
        .searchbar-textbox::-moz-selection {
            background-color: var(--col-t2) !important;
            background: var(--col-t2) !important;
        } 

        #urlbar-background, #searchbar {
            box-shadow: none !important;
        }

        .subviewbutton-iconic > .toolbarbutton-icon {
            fill: var(--rcol-fg) !important;
        }

        /*====== Colors ======*/
        /*link color in search box*/
        #urlbar-input,
        .urlbarView-row:not([type="tip"],
        [type="dynamic"])[selected] > .urlbarView-row-inner {
            color: var(--rcol-fg) !important;
        }
        #urlbar-scheme,
        .searchbar-textbox,
        .urlbarView-url {
            color: var(--rcol-blue) !important;
        }
        /*search window*/
        #urlbar-input::selection {
            color: var(--rcol-fg) !important;
            background-color: rgba(var(--rrgb-bg), 0.37) !important;
        }

        .urlbarView-row[selected] .urlbarView-row-inner,
        .urlbarView-row:hover .urlbarView-row-inner { 
            background-color: var(--rcol-mg) !important; 
        }


        /*====== Sidebery ========*/
        #TabsToolbar {
            visibility: collapse !important;
            display: none !important;
        } /* native tab bar */
        #sidebar-header {
            display: none !important;
        } /* panel title*/
        #sidebar-splitter { display: none !important; } /* panel separator */

        /*====== Aesthetics ======*/



        /* Sets the toolbar color */
        #navigator-toolbox {
            border-bottom: none !important;
            background: #0000 !important;
            backdrop-filter: blur(5px) blur(5px) blur(5px) !important;
        }

        #titlebar {
            background: #0000 !important;
            backdrop-filter: blur(5px) blur(5px) blur(5px) !important;
        }

        toolbar#nav-bar {
            background-image: var(--rwall-blur) !important;
            box-shadow: none !important;
        }

        /* Sets the URL bar color */
        #urlbar {
            background: #0000 !important;
            urlbar-input-box {
                text-align: left !important;
            }
        }

        #urlbar-background {
            background: #0000 !important;
            border: none !important;
        }

        #urlbar-input-container {
            border: none !important;
        }

        /* If the window is wider than 1000px, use flex layout */
        @media (min-width: 500px) {
            #navigator-toolbox {
                display: flex !important;
                flex-direction: row !important;
                flex-wrap: wrap !important;
            }

            /*  Url bar  */
            #nav-bar {
                order: 1;
                width: var(--navbarWidth) !important;
            }

            /* Tab bar */
            #titlebar {
                order: 2;
                width: calc(100vw - var(--navbarWidth) - 1px) !important;
            }

            /* Bookmarks bar */
            #PersonalToolbar {
                order: 3;
                width: 100% !important;
            }
            
            /* Fix urlbar sometimes being misaligned */
            :root[uidensity="compact"] #urlbar {
                --urlbar-toolbar-height: 39.60px !important;
            }

            :root[uidensity="touch"] #urlbar {
                --urlbar-toolbar-height: 49.00px !important;
            }
        }

        /*====== Simplifying interface ======*/

        /* Remove UI elements */
        #star-button-box { display:none !important; }
        #identity-box, /* Site information */
        #tracking-protection-icon-container, /* Shield icon */
        #page-action-buttons > :not(#urlbar-zoom-button, #star-button-box), /* All url bar icons except for zoom level and bookmarks */
        #urlbar-go-button, /* Search URL magnifying glass */
        #alltabs-button, /* Menu to display all tabs at the end of tabs bar */
        .titlebar-buttonbox-container /* Minimize, maximize, and close buttons */ {
            display: none !important;
        }

        #nav-bar {
            box-shadow: none !important;
        }

        /* Remove "padding" left and right from tabs */
        .titlebar-spacer {
            display: none !important;
        }

        /* Fix URL bar overlapping elements */
        #urlbar-container {
            min-width: initial !important;
        }

        /* Remove gap after pinned tabs */
        #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
        > #tabbrowser-arrowscrollbox
        > .tabbrowser-tab[first-visible-unpinned-tab] {
            margin-inline-start: 0 !important;
        }

        /* Hide the hamburger menu */
        #PanelUI-menu-button { 
            padding: 0px !important;
        }

        #PanelUI-menu-button .toolbarbutton-icon { 
            width: 1px !important; 
        }

        #PanelUI-menu-button .toolbarbutton-badge-stack {
            padding: 0px !important; 
        }

        /* TAB CENTER REBORN CONFIG */
        :root {
            /* delay before expanding tabs, set to '0' for no delay */
            --delay: 0.3s;
            --transition-time: 0.2s;
            --positionX1: 48px; /* '48px' for left, '0px' for right sidebar */
            --positionX2: absolute; /* 'absolute' for left, 'none' for right sidebar */
            /* width of the collapsed sidebar in fullscreen mode ('1px' or '48px') */
            --fullscreen-sidebar-width: 0px;
        }

        /* Linux/GTK specific styles */
        @media (-moz-gtk-csd-available),
               (-moz-platform: linux) {
            .browser-toolbar:not(.titlebar-color){ /* Fixes wrong coloring applied with --toolbar-bgcolor by Firefox (#101) */
                background-color: transparent !important;
                box-shadow: none !important;
            }

            #TabsToolbar:not([customizing="true"]) {
                visibility: collapse !important;
            }

            #toolbar-menubar {
                padding-top: 0px !important;
            }

            :root:not([customizing="true"]) #toolbar-menubar[inactive]+#TabsToolbar .titlebar-buttonbox-container {
                visibility: visible !important;
                position: absolute;
                top: var(--uc-win-ctrl-vertical-offset);
                display: block;
                z-index: 101;
            }

            /* enable rounded top corners */
            :root[tabsintitlebar][sizemode="normal"]:not([gtktiledwindow="true"]):not([customizing="true"]) #nav-bar {
                border-top-left-radius: env(-moz-gtk-csd-titlebar-radius);
                border-top-right-radius: env(-moz-gtk-csd-titlebar-radius);
            }

            /* window control padding values (these don't change the size of the actual buttons, only the padding for the navbar) */
            :root[tabsintitlebar]:not([customizing="true"]) {
                /* default button/padding size based on adw-gtk3 theme */
                --uc-win-ctrl-btn-width: 38px;
                --uc-win-ctrl-padding: 12px;
                /* vertical offset from the top of the window, calculation: (1/2 * (NAVBAR_HEIGHT - BUTTON_HEIGHT)) */
                --uc-win-ctrl-vertical-offset: 8px;
                /* extra window drag space */
                --uc-win-ctrl-drag-space: 20px;
            }

            :root[tabsintitlebar][lwtheme]:not([customizing="true"]) {
                /* seperate values for when using a theme, based on the Firefox defaults */
                --uc-win-ctrl-btn-width: 30px;
                --uc-win-ctrl-padding: 12px;
                /* vertical offset from the top of the window, calculation: (1/2 * (NAVBAR_HEIGHT - BUTTON_HEIGHT)) */
                --uc-win-ctrl-vertical-offset: 5px;
                /* extra window drag space */
                --uc-win-ctrl-drag-space: 20px;
            }

        }


        /* General styles */
        #browser {
            position: relative;
        }

        #nav-bar, #urlbar {
            z-index: 100;
        }

        #sidebar-box:not([lwt-sidebar]){
            appearance: unset !important;
        }

        #sidebar-box[sidebarcommand*="tabcenter"] {
            z-index: 1;
        }

        #sidebar-box[sidebarcommand*="tabcenter"] #sidebar-header {
            visibility: collapse;
            display: none;
        }
        
        #main-window:not([chromehidden~="toolbar"]) [sidebarcommand*="tabcenter"] #sidebar,
        #main-window:not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"] {
            display: block !important;
            min-width: 48px !important;
            max-width: 48px !important;
            width: 48px;
        }

        #main-window:not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"]:not([hidden]) {
            display: block;
            position: var(--positionX2);
            min-width: 48px;
            max-width: 48px;
            overflow: hidden;
            border-right: none !important;
            z-index: 1;
            top: 0;
            bottom: 0;
        }

        /* use :where() selector to lower specificity */
        :where(#main-window[inFullscreen]:not([chromehidden~="toolbar"])) #sidebar-box[sidebarcommand*="tabcenter"]:not([hidden]) {
            min-width: var(--fullscreen-sidebar-width) !important;
            max-width: var(--fullscreen-sidebar-width) !important;
        }

        #main-window:not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"]:hover #sidebar,
        #main-window:not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"]:hover {
            min-width: 10vw !important;
            width: 30vw !important;
            max-width: 200px !important;
            z-index: 1 !important;
            transition: all var(--transition-time) ease var(--delay);
        }

        /* used for delay function */
        #sidebar-box[sidebarcommand*="tabcenter"]:not(:hover) #sidebar,
        #sidebar-box[sidebarcommand*="tabcenter"]:not(:hover) {
            transition: all var(--transition-time) ease 0s;
        }

        @media (width >= 1200px) {
            #main-window:not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"]:hover #sidebar,
            #main-window:not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"]:hover {
                max-width: 250px !important;
            }
        }

        [sidebarcommand*="tabcenter"] ~ #sidebar-splitter {
            display: none;
        }

        [sidebarcommand*="tabcenter"] #sidebar {
            max-height: 100%;
            height: 100%;
        }

        #main-window:not([inFullscreen]):not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"]:not([hidden]) ~ #appcontent {
            margin-left: var(--positionX1);
        }

        #main-window[inFullscreen]:not([inDOMFullscreen]):not([chromehidden~="toolbar"]) #sidebar-box[sidebarcommand*="tabcenter"]:not([hidden]) ~ #appcontent {
            margin-left: var(--fullscreen-sidebar-width);
        }

        #main-window[inFullscreen] #sidebar {
            height: 100vh;
        }

        [sidebarcommand*="tabcenter"] #sidebar-header {
            background: #0000;
            border-bottom: none !important;
        }

        [sidebarcommand*="tabcenter"] #sidebar-switcher-target,
        [sidebarcommand*="tabcenter"] #sidebar-close {
            filter: invert(100%);
        }

        @media (max-width: 630px) {
            #urlbar-container {
                min-width: 100% !important;
            }

            #menubar-items {
                display: none !important;
            }
        }

        .sidebar-splitter {
            display: none !important
        }
    '';
}
