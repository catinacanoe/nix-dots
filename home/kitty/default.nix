{ config, inputs, pkgs, ... }:
with (import ../../rice);
{
    home.activation.kitty = inputs.home-manager.lib.hm.dag.entryAfter ["onFilesChange"]
        "$DRY_RUN_CMD kill $VERBOSE_ARG -SIGUSR1 $(${pkgs.procps}/bin/pgrep kitty)";

    xdg.configFile."kitty/copy-out.sh".executable = true;
    xdg.configFile."kitty/copy-out.sh".text = ''
        #!/usr/bin/env bash
        tmp="$(mktemp /tmp/kitty-get-text.XXXXXX)"
        out="$(mktemp /tmp/kitty-get-text.XXXXXX)"
        kitty @ get-text > "$tmp"

        ps="$(tail -n 1 "$tmp" | awk '{ print $1 }')"
        tac "$tmp" | tail -n +3 | sed "/^$ps/q" | tac > "$out"

        notify-send -- "$(head -n 1 "$out")" "$(tail -n +2 "$out")"
        wl-copy < "$out"

        rm "$tmp"
    '';

    programs.kitty = {
        enable = true;

        keybindings = {
            "ctrl+shift+c" = "copy_to_clipboard";
            "ctrl+shift+v" = "paste_from_clipboard";

            "ctrl+shift+y" = "remote_control_script ~/.config/kitty/copy-out.sh";

            "shift+up" = "scroll_line_up";
            "shift+down" = "scroll_line_down";

            "ctrl+shift+l" = "change_font_size all 0";
            "ctrl+shift+tab" = "change_font_size all +2.0";
            "ctrl+shift+u" = "change_font_size all -2.0";
        };

        settings = {
            clear_all_shortcuts = true;
            enable_audio_bell = false;
            window_alert_on_bell = false;
            confirm_os_window_close = 0;
            allow_remote_control = true;

            font_size = font.size;
            window_padding_width = if style.rounding then "4.7" else "2"; # u r d l
            scrollback_lines = 10000;
            update_check_interval = 0;
            mouse_hide_wait = 0;

            font_family = font.full.family;
            bold_font = font.full.bold;
            italic_font = font.full.italic;
            bold_italic_font = font.full.bold-italic;

            touch_scroll_multiplier = "1.7";
            wheel_scroll_multiplier = "5.0";

            disable_ligatures = "cursor";
            strip_trailing_spaces = "smart";
            copy_on_select = "clipboard";

            cursor = "${col.fg.h}";
            cursor_shape = "beam";
            cursor_beam_thickness = "1.5";
            cursor_stop_blinking_after = 0;
            cursor_text_color = "${col.fg.h}";

            open_url_with = "${config.home.sessionVariables.BROWSER}";
            url_color = "${col.blue.h}";
            url_style = "curly";
            undercurl_style = "thick-sparse";
            underline_hyperlinks = "always";

            background_opacity = "0.7";
            foreground = "${col.fg.h}";
            background = "${col.bg.h}";
            color0  = "${col.bg.h}";
            color8  = "${col.t2.h}";
            color1  = "${col.red.h}";
            color9  = "${col.red.h}";
            color2  = "${col.green.h}";
            color10 = "${col.green.h}";
            color3  = "${col.yellow.h}";
            color11 = "${col.orange.h}";
            color4  = "${col.blue.h}";
            color12 = "${col.blue.h}";
            color5  = "${col.purple.h}";
            color13 = "${col.purple.h}";
            color6  = "${col.aqua.h}";
            color14 = "${col.aqua.h}";
            color7  = "${col.t4.h}";
            color15 = "${col.fg.h}";
            mark1_foreground = "${col.bg.h}";
            mark1_background = "${col.blue.h}";
            mark2_foreground = "${col.bg.h}";
            mark2_background = "${col.aqua.h}";
            mark3_foreground = "${col.bg.h}";
            mark3_background = "${col.yellow.h}";

            # color spam below :)
            color16  = "${col.t0.h}";
            color17  = "${col.blue.h}";
            color18  = "${col.blue.h}";
            color19  = "${col.blue.h}";
            color20  = "${col.blue.h}";
            color21  = "${col.blue.h}";
            color22  = "${col.green.h}";
            color23  = "${col.blue.h}";
            color24  = "${col.blue.h}";
            color25  = "${col.blue.h}";
            color26  = "${col.blue.h}";
            color27  = "${col.blue.h}";
            color28  = "${col.green.h}";
            color29  = "${col.green.h}";
            color30  = "${col.aqua.h}";
            color31  = "${col.blue.h}";
            color32  = "${col.blue.h}";
            color33  = "${col.blue.h}";
            color34  = "${col.green.h}";
            color35  = "${col.green.h}";
            color36  = "${col.aqua.h}";
            color37  = "${col.aqua.h}";
            color38  = "${col.blue.h}";
            color39  = "${col.blue.h}";
            color40  = "${col.green.h}";
            color41  = "${col.green.h}";
            color42  = "${col.green.h}";
            color43  = "${col.aqua.h}";
            color44  = "${col.aqua.h}";
            color45  = "${col.blue.h}";
            color46  = "${col.green.h}";
            color47  = "${col.green.h}";
            color48  = "${col.green.h}";
            color49  = "${col.aqua.h}";
            color50  = "${col.aqua.h}";
            color51  = "${col.aqua.h}";
            color52  = "${col.brown.h}";
            color53  = "${col.purple.h}";
            color54  = "${col.purple.h}";
            color55  = "${col.purple.h}";
            color56  = "${col.purple.h}";
            color57  = "${col.purple.h}";
            color58  = "${col.orange.h}";
            color59  = "${col.t2.h}";
            color60  = "${col.t2.h}";
            color61  = "${col.purple.h}";
            color62  = "${col.purple.h}";
            color63  = "${col.purple.h}";
            color64  = "${col.green.h}";
            color65  = "${col.aqua.h}";
            color66  = "${col.aqua.h}";
            color67  = "${col.blue.h}";
            color68  = "${col.blue.h}";
            color69  = "${col.blue.h}";
            color70  = "${col.green.h}";
            color71  = "${col.green.h}";
            color72  = "${col.green.h}";
            color73  = "${col.aqua.h}";
            color74  = "${col.aqua.h}";
            color75  = "${col.blue.h}";
            color76  = "${col.green.h}";
            color77  = "${col.green.h}";
            color78  = "${col.green.h}";
            color79  = "${col.aqua.h}";
            color80  = "${col.aqua.h}";
            color81  = "${col.blue.h}";
            color82  = "${col.green.h}";
            color83  = "${col.green.h}";
            color84  = "${col.green.h}";
            color85  = "${col.aqua.h}";
            color86  = "${col.aqua.h}";
            color87  = "${col.aqua.h}";
            color88  = "${col.brown.h}";
            color89  = "${col.brown.h}";
            color90  = "${col.purple.h}";
            color91  = "${col.purple.h}";
            color92  = "${col.purple.h}";
            color93  = "${col.purple.h}";
            color94  = "${col.orange.h}";
            color95  = "${col.orange.h}";
            color96  = "${col.purple.h}";
            color97  = "${col.purple.h}";
            color98  = "${col.purple.h}";
            color99  = "${col.purple.h}";
            color100  = "${col.yellow.h}";
            color101  = "${col.yellow.h}";
            color102  = "${col.t3.h}";
            color103  = "${col.t3.h}";
            color104  = "${col.purple.h}";
            color105  = "${col.purple.h}";
            color106  = "${col.green.h}";
            color107  = "${col.green.h}";
            color108  = "${col.aqua.h}";
            color109  = "${col.aqua.h}";
            color110  = "${col.blue.h}";
            color111  = "${col.blue.h}";
            color112  = "${col.green.h}";
            color113  = "${col.green.h}";
            color114  = "${col.aqua.h}";
            color115  = "${col.aqua.h}";
            color116  = "${col.aqua.h}";
            color117  = "${col.blue.h}";
            color118  = "${col.green.h}";
            color119  = "${col.green.h}";
            color120  = "${col.aqua.h}";
            color121  = "${col.aqua.h}";
            color122  = "${col.aqua.h}";
            color123  = "${col.blue.h}";
            color124  = "${col.brown.h}";
            color125  = "${col.brown.h}";
            color126  = "${col.red.h}";
            color127  = "${col.purple.h}";
            color128  = "${col.purple.h}";
            color129  = "${col.purple.h}";
            color130  = "${col.orange.h}";
            color131  = "${col.orange.h}";
            color132  = "${col.orange.h}";
            color133  = "${col.purple.h}";
            color134  = "${col.purple.h}";
            color135  = "${col.purple.h}";
            color136  = "${col.yellow.h}";
            color137  = "${col.yellow.h}";
            color138  = "${col.orange.h}";
            color139  = "${col.purple.h}";
            color140  = "${col.purple.h}";
            color141  = "${col.purple.h}";
            color142  = "${col.green.h}";
            color143  = "${col.green.h}";
            color144  = "${col.t4.h}";
            color145  = "${col.t4.h}";
            color146  = "${col.purple.h}";
            color147  = "${col.purple.h}";
            color148  = "${col.green.h}";
            color149  = "${col.green.h}";
            color150  = "${col.green.h}";
            color151  = "${col.aqua.h}";
            color152  = "${col.aqua.h}";
            color153  = "${col.blue.h}";
            color154  = "${col.green.h}";
            color155  = "${col.green.h}";
            color156  = "${col.green.h}";
            color157  = "${col.aqua.h}";
            color158  = "${col.aqua.h}";
            color159  = "${col.aqua.h}";
            color160  = "${col.red.h}";
            color161  = "${col.red.h}";
            color162  = "${col.red.h}";
            color163  = "${col.purple.h}";
            color164  = "${col.purple.h}";
            color165  = "${col.purple.h}";
            color166  = "${col.orange.h}";
            color167  = "${col.orange.h}";
            color168  = "${col.orange.h}";
            color169  = "${col.purple.h}";
            color170  = "${col.purple.h}";
            color171  = "${col.purple.h}";
            color172  = "${col.orange.h}";
            color173  = "${col.orange.h}";
            color174  = "${col.orange.h}";
            color175  = "${col.purple.h}";
            color176  = "${col.purple.h}";
            color177  = "${col.purple.h}";
            color178  = "${col.orange.h}";
            color179  = "${col.yellow.h}";
            color180  = "${col.yellow.h}";
            color181  = "${col.purple.h}";
            color182  = "${col.purple.h}";
            color183  = "${col.purple.h}";
            color184  = "${col.yellow.h}";
            color185  = "${col.yellow.h}";
            color186  = "${col.yellow.h}";
            color187  = "${col.yellow.h}";
            color188  = "${col.t5.h}";
            color189  = "${col.purple.h}";
            color190  = "${col.yellow.h}";
            color191  = "${col.yellow.h}";
            color192  = "${col.aqua.h}";
            color193  = "${col.aqua.h}";
            color194  = "${col.aqua.h}";
            color195  = "${col.blue.h}";
            color196  = "${col.red.h}";
            color197  = "${col.red.h}";
            color198  = "${col.red.h}";
            color199  = "${col.red.h}";
            color200  = "${col.purple.h}";
            color201  = "${col.purple.h}";
            color202  = "${col.orange.h}";
            color203  = "${col.orange.h}";
            color204  = "${col.orange.h}";
            color205  = "${col.purple.h}";
            color206  = "${col.purple.h}";
            color207  = "${col.purple.h}";
            color208  = "${col.orange.h}";
            color209  = "${col.orange.h}";
            color210  = "${col.orange.h}";
            color211  = "${col.purple.h}";
            color212  = "${col.purple.h}";
            color213  = "${col.purple.h}";
            color214  = "${col.yellow.h}";
            color215  = "${col.orange.h}";
            color216  = "${col.orange.h}";
            color217  = "${col.purple.h}";
            color218  = "${col.purple.h}";
            color219  = "${col.purple.h}";
            color220  = "${col.yellow.h}";
            color221  = "${col.yellow.h}";
            color222  = "${col.yellow.h}";
            color223  = "${col.yellow.h}";
            color224  = "${col.purple.h}";
            color225  = "${col.purple.h}";
            color226  = "${col.yellow.h}";
            color227  = "${col.yellow.h}";
            color228  = "${col.yellow.h}";
            color229  = "${col.t6.h}";
            color230  = "${col.t6.h}";
            color231  = "${col.fg.h}";
            color232  = "${col.t0.h}";
            color233  = "${col.t0.h}";
            color234  = "${col.t0.h}";
            color235  = "${col.t1.h}";
            color236  = "${col.t1.h}";
            color237  = "${col.t1.h}";
            color238  = "${col.t2.h}";
            color239  = "${col.t2.h}";
            color240  = "${col.t2.h}";
            color241  = "${col.t3.h}";
            color242  = "${col.t3.h}";
            color243  = "${col.t3.h}";
            color244  = "${col.t4.h}";
            color245  = "${col.t4.h}";
            color246  = "${col.t4.h}";
            color247  = "${col.t5.h}";
            color248  = "${col.t5.h}";
            color249  = "${col.t5.h}";
            color250  = "${col.t6.h}";
            color251  = "${col.t6.h}";
            color252  = "${col.t6.h}";
            color253  = "${col.t7.h}";
            color254  = "${col.t7.h}";
            color255  = "${col.t7.h}";
        };
    };
}
