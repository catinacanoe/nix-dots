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

            auto-reload no

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

            browser "drop && ${config.home.sessionVariables.BROWSER}"
        '';

        urls = [
            { title = "~~ music ~~~"; url = ""; tags = []; }
            { title = "Aden Foyer"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCktCCsmFnLxDv8c9xfI-i3g"; tags = [ "music" "yt" ]; }
            { title = "Alan Walker"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJrOtniJ0-NWz37R30urifQ"; tags = [ "music" "yt" ]; }
            { title = "Animadrop"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC5SDreU0tqZdl44wYIRCMdg"; tags = [ "music" "yt" ]; }
            { title = "Apashe"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC8jBJ3QGa72lLr3a8JvBenQ"; tags = [ "music" "yt" ]; }
            { title = "Attack Attack!"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC3gTp-3Ra28mpZwyo_xeMxQ"; tags = [ "music" "yt" ]; }
            { title = "Au/Ra"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCoGJ6tHb493zmR2yZaPszcQ"; tags = [ "music" "yt" ]; }
            { title = "Azali"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9UKPs9ZisfhMJdalnETLRg"; tags = [ "music" "yt" ]; }
            { title = "Benken"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCWDETt34fg4Q0ArQAmnlCNA"; tags = [ "music" "yt" ]; }
            { title = "Bossfight"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCTK4l10G77oDhOjIaxS3vcQ"; tags = [ "music" "yt" ]; }
            { title = "Creo"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCsCWA3Y3JppL6feQiMRgm6Q"; tags = [ "music" "yt" ]; }
            { title = "Dalux"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UChZS1_df2_r3e-xcditM8Sg"; tags = [ "music" "yt" ]; }
            { title = "Dogma"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCz8DiAgwpn2Tik3pQsvYspA"; tags = [ "music" "yt" ]; }
            { title = "DNIE"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCVU2R5rkBL2Qfh8GAqCWwPQ"; tags = [ "music" "yt" ]; }
            { title = "DROELOE"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCc-HpMqHY3VjptiG18JExNw"; tags = [ "music" "yt" ]; }
            { title = "DSG"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCG6QEHCBfWZOnv7UVxappyw"; tags = [ "music" "yt" ]; }
            { title = "Exyl"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCNgchdiFrWvmjXKOKX5Vfsg"; tags = [ "music" "yt" ]; }
            { title = "Future Twist"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCLgGfIkBf2zNEKE1a7_CCDA"; tags = [ "music" "yt" ]; }
            { title = "Geoxor"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCIPihBzEXYFiYfFwYCwWpKg"; tags = [ "music" "yt" ]; }
            { title = "Instinct"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCp8OOssjSjGZRVYK6zWbNLg"; tags = [ "music" "yt" ]; }
            { title = "Just A Gent"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCHF2t_e-Zrtv8ZpGa_Vkw8g"; tags = [ "music" "yt" ]; }
            { title = "Kirara Magic"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCuvTwfKsTMgFW-i8NZfKfHg"; tags = [ "music" "yt" ]; }
            { title = "Knock2"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCdb3pfoDoMOl-oMS1Ldsmiw"; tags = [ "music" "yt" ]; }
            { title = "Lana Del Rey"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCqk3CdGN_j8IR9z4uBbVPSg"; tags = [ "music" "yt" ]; }
            { title = "monophob1a"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCmsd3bR4TgGlF4vqJfGRpw"; tags = [ "music" "yt" ]; }
            { title = "NCS"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_aEa8K-EOJ3D6gOs7HcyNg"; tags = [ "music" "yt" ]; }
            { title = "onumi"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCo6SOU05yhr-M38av2usUqw"; tags = [ "music" "yt" ]; }
            { title = "Panda Eyes"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCVV8P2rXgrid1-73C44r-hg"; tags = [ "music" "yt" ]; }
            { title = "Paper Skies"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCnIVKmDbzDP7CPNQyfhcufg"; tags = [ "music" "yt" ]; }
            { title = "Rival"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCl-GRbrjrohkrnW9-AByAVg"; tags = [ "music" "yt" ]; }
            { title = "Sekai"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9ZeMfZZSFUyeNHnFInYtgA"; tags = [ "music" "yt" ]; }
            { title = "Similar Outskirts"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCtxKzA7OSpRh3OX9aJRShUg"; tags = [ "music" "yt" ]; }
            { title = "Skybreak"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCVkwPo62gvyjGC0145Jllmg"; tags = [ "music" "yt" ]; }
            { title = "Sunnexo"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCXhT0cnAVlZ2htMuG5vg4fw"; tags = [ "music" "yt" ]; }
            { title = "Tanger"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9ZwldU8Fv1dPPUyzhfomkQ"; tags = [ "music" "yt" ]; }
            { title = "Teminite"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCc_bv_5nmxy2xnPNg9kP3Rg"; tags = [ "music" "yt" ]; }
            { title = "tn-shi"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC-NStn927rkPlj85972VfoA"; tags = [ "music" "yt" ]; }
            { title = "Tri Dna"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCL--XzbPTDS6MIJvO5R97ZQ"; tags = [ "music" "yt" ]; }
            { title = "Uncaged"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJ6td3C9QlPO9O_J5dF4ZzA"; tags = [ "music" "yt" ]; }
            { title = "updog"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCwyCWQHweVQO-_PGRTBW4CQ"; tags = [ "music" "yt" ]; }
            { title = "Valiant"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCGwALZJISywbMsd3QPvvrDQ"; tags = [ "music" "yt" ]; }
            { title = "Virtual Riot"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCVtJOq_ziepf5MpjsTWxJeg"; tags = [ "music" "yt" ]; }
            { title = "YMIR"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCTXF9frC6mf1inolP9VakKQ"; tags = [ "music" "yt" ]; }
            { title = "Yoasobi"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCvpredjG93ifbCP1Y77JyFA"; tags = [ "music" "yt" ]; }
            { title = "zwe1hvndxr"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UChBweVTqoBcn5wWn3f9u-Vw"; tags = [ "music" "yt" ]; }

            { title = "~~ kaizen ~~~"; url = ""; tags = []; }
            { title = "Ruri Ohama"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCKtiMrNZq0gGbPTnsMu7Bsw"; tags = [ "kaizen" "yt" ]; }

            { title = "~~ fun ~~~"; url = ""; tags = []; }
            { title = "Veronica Vlogs"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCQt5ygdMXv-nsNiV2c2hU3w"; tags = [ "fun" "yt" ]; }
            { title = "Shoe0nHead"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC0aanx5rpr7D1M7KCFYzrLQ"; tags = [ "fun" "yt" ]; }
            { title = "Acerola"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCQG40havu4kNpB4pxUDQhYQ"; tags = [ "fun" "yt" ]; }
            { title = "GEN"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCF9OHrRasw-r4JcnBo4E2cg"; tags = [ "fun" "yt" ]; }
            { title = "Adam Something"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCcvfHa-GHSOHFAjU0-Ie57A"; tags = [ "fun" "yt" ]; }
            { title = "Alpha Phoenix"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCWeRTgd79JL0ilH0ZywSJA"; tags = [ "fun" "yt" ]; }
            { title = "Vhyrro"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCBKNuaxVlSNvIN139KplUKw"; tags = [ "fun" "yt" ]; }
            { title = "Luke Smith"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA"; tags = [ "fun" "yt" ]; }
            { title = "Revlox"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCE9OrwUdrrjTDdHOSh_Ntw"; tags = [ "fun" "yt" ]; }
            { title = "Code Aesthetic"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCaSCt8s_4nfkRglWCvNSDrg"; tags = [ "fun" "yt" ]; }
            { title = "Code Ahead"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCT8O7AoO468ZgEEC83NAJ0g"; tags = [ "fun" "yt" ]; }
            { title = "t3ssel8r"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCIjUIjWig0r5DIixQrt6A3A"; tags = [ "fun" "yt" ]; }
            { title = "Carbon"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCMOBdfLjLT-PzrGzld8GjRw"; tags = [ "fun" "yt" ]; }
            { title = "Dani"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCIabPXjvT5BVTxRDPCBBOOQ"; tags = [ "fun" "yt" ]; }
        ];
    };
}
