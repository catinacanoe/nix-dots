{ config, ... }: {
    xdg.configFile."mpd/mpd.conf".text = ''
        music_directory "${config.xdg.userDirs.music}"

        replaygain "track"
        restore_paused "yes"

        input {
            plugin "curl"
        }

        audio_output {
            type "pipewire"
            name "pipewire"
        }
    '';
}
