{ inputs, pkgs, ... }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
    programs.spicetify = {
        enable = true;
        theme = spicePkgs.themes.text;
        # colorScheme = "catppuccinmocha";

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
