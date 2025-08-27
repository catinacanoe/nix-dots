{ config, ... }: {
    programs.newsboat = {
        enable = true;

        reloadTime = 30;
        reloadThreads = 8;
        autoReload = true;

        extraConfig = ''
            color info                                    default  default
            color article                                 default  default
            color background                              default  default
            color listnormal                              default  default
            color listnormal_unread                       yellow   default
            color listfocus                               green    default  bold underline
            color listfocus_unread                        yellow   default  bold underline

            highlight article "^(Feed|Link):.*$"          color11  default  bold
            highlight article "^(Title|Date|Author):.*$"  color11  default  bold
            highlight article "https?://[^ ]+"            blue     default  underline
            highlight article "\\[[0-9]+\\]"              color2   default  bold
            highlight article "\\[image\\ [0-9]+\\]"      color2   default  bold

            highlight feedlist "^.*~~.*~~~.*$"            magenta  default  bold

            bind-key n quit
            bind-key a up
            bind-key i down
            bind-key o open

            bind-key A prev-unread
            bind-key I next-unread

            bind-key e toggle-article-read

            bind-key g home
            bind-key G end

            bind-key ; hard-quit

            bind-key TAB macro-prefix
            macro l set browser "open(){ echo $1 >> /tmp/mustagger.in;}; open" ; open-in-browser-and-mark-read ; set browser "drop && ${config.home.sessionVariables.BROWSER}"
        '';
        
        browser = "\"${config.home.sessionVariables.TERMINAL} mpv --input-ipc-server=~/.config/mpvc/mpvsocket0 %u\"";

        urls = [
            { title = "Not Even Emily"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UChhyfYkhuVrzmvDr-WqpDSw"; }
            { title = "Ben Hoerman";    url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC433I43L6Yz3SnAC9BZxdIQ"; }
            { title = "Jaye Alexander"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC1rhRwPCmoGz_FDJ3nhTQVg"; }
            { title = "oliSUNvia";      url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCVHxJghKAB_kA_5LMM8MD3w"; }
            { title = "aini";           url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCbIu3t4VRulEQbLnCXd2d_w"; }
            { title = "Alpha Phoenix";  url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCWeRTgd79JL0ilH0ZywSJA"; }
            { title = "Acerola";        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCQG40havu4kNpB4pxUDQhYQ"; }
            { title = "Gixxer Brah";    url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCmsBN6VzWgm391Yf6hjPpTw"; }
            { title = "keem";           url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCgSEzJYUvzPpe4IF4H03AKQ"; }
            { title = "Revlox";         url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCE9OrwUdrrjTDdHOSh_Ntw"; }
            { title = "Shoe0nHead";     url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC0aanx5rpr7D1M7KCFYzrLQ"; }
            { title = "Luke Smith";     url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA"; }
            { title = "TechJoyce";      url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCR4ZpFWX29p4YCajQA5fcfQ"; }
            { title = "Veronica Vlogs"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCQt5ygdMXv-nsNiV2c2hU3w"; }
            { title = "ash callaghan";  url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCSX6zq83jCHK1Y24sdiye-A"; }
            { title = "t3ssel8r";       url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCIjUIjWig0r5DIixQrt6A3A"; }
        ];
    };
}
