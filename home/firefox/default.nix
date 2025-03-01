{ config, ... }:
let 
    prefix = ".mozilla/firefox";
    rice = (import ../../rice);
    usercontent = /* css */ ''
        :root {
            scrollbar-width: none !important;
            ${import ./modules/vars.nix rice}
        }

        * { scrollbar-width: none !important; }

        @-moz-document url-prefix("about:") {
            :root {
                --in-content-page-background: var(--rcol-bg) !important;
                --background-color-box: var(--rcol-t1) !important;
                --color-accent-primary: var(--rcol-blue) !important;
                --color-accent-primary-hover: rgba(var(--rrgb-blue), 0.7) !important;
                --in-content-page-color: var(--rcol-fg) !important;
            }

            #policies-container, #searchInput {
                background-color: var(--rcol-t1) !important;
            }
        }
    '';

    # about:config - browser.fullscreen.autohide
    # set to false to keep navbar present in fullscreen

    userchrome-full = /* css */ ''
        :root {
            ${import ./modules/vars.nix rice}

            --navbarWidth: 100vw;
            --focus-outline-color: transparent !important;

            --lwt-toolbar-field-highlight: var(--rcol-t2) !important;
            --urlbar-box-bgcolor: rgba(var(--rrgb-fg), 0.1) !important;

            /* ctrl f find in page bar */
            --toolbar-color: var(--rcol-fg) !important;
            --toolbar-field-focus-color: var(--rcol-fg) !important;
            --toolbar-bgcolor: var(--rcol-bg) !important;
            --input-border-color: var(--rcol-bg) !important;
            --toolbar-field-focus-background-color: var(--rcol-bg) !important;

            /* side panel: history and bookmarks */
            --toolbar-non-lwt-bgcolor: var(--rcol-bg) !important;
            --toolbar-field-background-color: var(--rcol-bg) !important;
            --toolbar-color-scheme: dark !important;
            --background-color-box: var(--rcol-bg) !important;
            -moz-dialogtext: var(--rcol-fg) !important;
            background: var(--rcol-bg) !important;
            color: var(--rcol-fg) !important;
        }

        /****************************************************************/
        /* side panel
        /****************************************************************/
        search-textbox#search-box {
            color: var(--rcol-bg) !important;
        }

        hbox#browser,
        vbox#sidebar-box,
        browser#sidebar,
        xxx { background: var(--rcol-bg) !important; }

        /****************************************************************/
        /* ctrl f find in page bar */
        /****************************************************************/
        .findbar-highlight, .findbar-case-sensitive, .findbar-match-diacritics, .findbar-label,
        .findbar-entire-word, .findbar-find-previous, .findbar-find-next, .findbar-closebutton,
        xxx { display: none !important; }

        hbox[anonid="findbar-textbox-wrapper"] { width: 100% !important; }
        .findbar-textbox {
            width: 100% !important;
            border: none !important;
            border-radius: 5px !important;
            &[status="notfound"] {
                background-color: inherit !important;
                color: var(--rcol-red) !important;
            }
        }

        findbar { border: none !important; }

        toolbarspring, /* the wierd padding right of zoom level */
        xxx { display: none !important; }

        browser#webext-panels-browser {
            background-color: var(--rcol-bg);
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
        #urlbar-input::selection { /* highlighted text */
            color: var(--rcol-fg) !important;
            background-color: rgba(var(--rrgb-fg), 0.2) !important;
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
        
        /*************************************************************/
        /* SEARCHBAR TOOLBAR NAVBAR (this can be made transparent and it works) */
        /*************************************************************/
        toolbar#nav-bar {
            box-shadow: none !important;
            background-color: var(--rcol-bg) !important;
            /* ${let host = (import ../../ignore-hostname.nix); in if host == "nixbox" then '' */
            /* background-size: 3840px; */
            /* background-position: -19px -259px; */
            /* '' else if host == "nixpad" then '' */
            /* background-size: 1920px; */
            /* background-position: -22px -107px; */
            /* '' else ""} */
        }
        vbox.urlbarView { display: none !important; } /* some wierd gray box around searchbar */
        
        /************************************************/
        /* right click and other menus */
        /************************************************/
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
                color: var(--rcol-blue) !important;
                background-color: #0000 !important;
            }
        }

        /*************************************************************/
        /* Modifying the right click menu (context menu) */
        /* https://safereddit.com/r/firefox/comments/7dvtw0/guide_how_to_edit_your_context_menu/ */
        /*************************************************************/
        /* right click on page */
        #context-savepage,
        #context-selectall,
        #screenshots_mozilla_org_create-screenshot,
        #context-inspect-a11y, #context-inspect,
        #context-navigation,
        #context-viewsource,
        /* right click on image */
        #context-sendimage,
        /* right click on link */
        #context-openlinkintab,
        #context-openlinkinusercontext-menu,
        #context-openlink,
        #context-openlinkprivate,
        #context-bookmarklink,
        #context-savelink,
        #context-savelinktopocket,
        #context-sendlinktodevice,
        #context-viewpartialsource-selection,
        #simple-translate_sienori-menuitem-_translateLink,
        menu[label="LibRedirect"], menuitem[label="LibRedirect"],
        /* right click on selection */
        #context-searchselect,
        #context-print-selection,
        /* tree style tabs (right click on tab) */
        #tabcenter-reborn_ariasuni-menuitem-_contextMenuReloadTab,
        #tabcenter-reborn_ariasuni-menuitem-_contextMenuUnloadTab,
        #tabcenter-reborn_ariasuni-menuitem-_contextMenuOpenInContextualTab,
        #tabcenter-reborn_ariasuni-menuitem-_contextMenuMoveTab,
        #tabcenter-reborn_ariasuni-menuitem-_contextMenuCloseTabs,
        #tabcenter-reborn_ariasuni-menuitem-_contextMenuUndoCloseTab,
        #tabcenter-reborn_ariasuni-menuitem-_contextMenuCloseTab,
        #context-sep-viewsource-commands,
        #simple-translate_sienori-menuitem-_translatePageOnTab,
        menuseparator[id*="tabcenter-reborn_ariasuni-menuitem"],
        /* extensions settings context menu */
        #unified-extensions-context-menu-pin-to-toolbar,
        /* separators */
        #context-sep-setbackground,
        #context-sep-open,
        #context-sep-selectall,
        #context-sep-sendlinktodevice,
        #context-sep-navigation,
        #context-sep-sendpagetodevice,
        #context-sep-viewbgimage,
        #context-sep-viewsource,
        #context-media-eme-separator,
        #frame-sep,
        #inspect-separator,
        xxx { display: none !important; }

        /* the below removes icons and left padding */
        .menu-iconic-left {
            visibility: hidden !important;
        }
        menupopup#contentAreaContextMenu,
        menupopup#unified-extensions-context-menu {
            menu.menu-iconic,
            menuitem {
                padding-right: 0px !important;
                margin-right: -8px !important;
                margin-left: -22px !important;
            }
            hbox.menu-right {
                padding-right: 5px !important;
            }
        }


        /******************************************************************************/
        /* Extensions panel */
        /******************************************************************************/
        panel#unified-extensions-panel { /* exterior of the entire panel */
            padding-top: 4px !important;
            margin-right: -3px !important;
        }
        box.panel-viewstack { /* entire panel */
            padding: 3px 0px !important;
        }
        panelview#unified-extensions-view { /* entire list */
            max-width: 300px;
            font-size: 1em !important;
        }

        unified-extensions-item.toolbaritem-combined-buttons,
        toolbaritem[class*="toolbaritem-combined-buttons"] { /* entire list entry */
            padding: 0px 3px !important;
            margin: 0px !important;
        }

        image.unified-extensions-item-icon,
        stack.toolbarbutton-badge-stack { /* ext icon */
            transform: scale(0.7) !important;
        }
        toolbarbutton[class*="unified-extensions-item-action"], /* ext name (incl icon) */
        toolbarbutton[class*="unified-extensions-item-menu"] { /* settings */
            padding: 0px !important;
            &:not([disabled]):hover {
                image.toolbarbutton-icon {
                    fill: var(--rcol-blue) !important;
                    color: #0000 !important;
                }
            }
        }

        /* entries on hover */
        :is(panelview .toolbarbutton-1, toolbarbutton.subviewbutton, .widget-overflow-list .toolbarbutton-1, .toolbaritem-combined-buttons:is(:not([cui-areatype="toolbar"]), [overflowedItem="true"]) > toolbarbutton) {
            &:not([disabled]):hover {
                color: var(--rcol-blue) !important;
                background-color: #0000 !important;
            }
        }

        toolbarbutton#unified-extensions-manage-extensions, /* manage extensions button */
        deck.unified-extensions-item-message-deck, /* secondary text under ext name */
        box.panel-header, /* header: extensions */
        toolbarseparator, /* all the separators */
        xxx {display:none!important;}


        /***********************************************************/
        /* rounding the topleft corner of the main browser frame */
        /***********************************************************/
        stack.browserStack browser {
            border-radius: ${toString rice.window.radius}px 0px 0px 0px !important;
        }
        vbox.browserContainer { /* & make sure the corner matches all colors */
            background: var(--rcol-bg) !important;
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
        /* @media (min-width: 500px) { */
        @media (min-width: 1px) {
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
            --fullscreen-sidebar-width: 48px;
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
            z-index: 3;
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
            width: 20vw !important;
            /* max-width: 250px !important; */
            max-width: 20vw !important; /*mark* */ 
            z-index: 3 !important;
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

        #main-window:not([inFullscreen]) #sidebar-box[sidebarcommand*="tabcenter"]:not([hidden]) ~ #tabbrowser-tabbox {
            margin-left: var(--positionX1) !important;
        }

        #main-window[inFullscreen]:not([inDOMFullscreen]) #sidebar-box[sidebarcommand*="tabcenter"]:not([hidden]) ~ #tabbrowser-tabbox {
            margin-left: var(--fullscreen-sidebar-width) !important;
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
            filter: none;
            /* filter: invert(100%); */
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
in
{
    home.file."${prefix}/main/chrome/userContent.css".text = usercontent;
    home.file."${prefix}/main/chrome/userChrome.css".text = userchrome-full;
}
