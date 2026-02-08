{ inputs, pkgs, ... }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    col = (import ../../rice).col;
in {
    programs.spicetify = {
        enable = false;
        theme = spicePkgs.themes.text;
        colorScheme = "custom";
        customColorScheme = {
            # accent             = "#1db954";
            # accent-active      = "#1ed760";
            # accent-inactive    = "#121212";
            # banner             = "#1ed760";
            # border-active      = "#1ed760";
            # border-inactive    = "#535353";
            # header             = "#535353";
            # highlight          = "#1a1a1a";
            # main               = "#121212";
            # notification       = "#4687d6";
            # notification-error = "#e22134";
            # subtext            = "#b3b3b3";
            # text               = "#FFFFFF";
            accent             = col.fg.hex; # slider: covered, checked toggle
            accent-active      = col.fg.hex; # prog-bar covered, liked marker, play button, title of playing song/playlist, hovered toggle
            accent-inactive    = col.t2.hex; # prog-bar left-to-go, unchecked toggle
            banner             = col.blue.hex; # 'spotify-tui' text (and playlist title when opening playlist)
            border-active      = col.fg.hex; # focused panel border AND title
            border-inactive    = col.t5.hex; # unfocused panel border (and also playback control buttons?)
            header             = col.blue.hex; # title of unfocused panels
            highlight          = col.mg.hex; # background of hovered item (also divider between song name and artist name)
            main               = col.bg.hex; # background of everything
            notification       = col.green.hex;
            notification-error = col.red.hex;
            subtext            = col.t5.hex;
            text               = col.fg.hex;
        };

        # good themes:
        # catppuccin, onepunch (gruv)
        # bloom, !hazy, text

        enabledCustomApps = with spicePkgs.apps; [
            betterLibrary
        ];

        enabledExtensions = with spicePkgs.extensions; [
            # keyboardShortcut # will have to write my own version
            shuffle
            copyToClipboard
            hidePodcasts
            seekSong
            beautifulLyrics
        ];

        enabledSnippets = with spicePkgs.snippets; let
            hideVolumeSlider = /*css*/''div[data-testid="volume-bar"] { display: none !important; }'';
        in [
            fixLikedIcon
            fixDjIcon
            hideMadeForYou
            disableRecommendations
            removeEpLikes # rm likes and saved episodes from sidebar
            hideLikedSongsCard # redundant to above possibly
            hideNowPlayingViewButton
            hideLyricsButton
            hideMiniPlayerButton
            hideFullScreenButton
            hideVolumeSlider
        ];
    };
}
