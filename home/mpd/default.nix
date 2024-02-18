{ config, ... }: {
    services.mpd = {
        enable = true;
        musicDirectory = config.xdg.userDirs.music;
        extraConfig = ''
        replaygain "track"
        restore_paused "yes"

        input {
            plugin "curl"
        }
        '';
        # volume_normalization "yes"
    };
}
