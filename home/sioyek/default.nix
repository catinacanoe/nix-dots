{ ... }:
with (import ../../rice);
with col.rgb01;
{
    programs.zsh.shellAliases.sy = /* bash */
        ''echo "tmp=$(mktemp) && cp \"%%%\" \$tmp && echo \"rm \$tmp\" | at now + 2 min && sioyek \$tmp" | yargs'';

    programs.sioyek = {
        enable = true;

        config = {
            "startup_commands" = "toggle_custom_color";
            "should_launch_new_window" = "1";
            "collapsed_toc" = "1";

            "background_color" = bg;
            "custom_background_color" = bg;
            "custom_text_color" = fg;


            "text_highlight_color" = blue;
            "search_highlight_color" = yellow;
            "link_highlight_color" = blue;
            "synctex_highlight_color" = blue;


            "ui_font" = font.full.family;
            "font_size" = toString font.size;

            "ui_background_color" = bg;
            "ui_text_color" = fg;

            "ui_selected_background_color" = purple;
            "ui_selected_text_color" = bg;


            "status_bar_color" = t1;
            "status_bar_text_color" = fg;
            "status_bar_font_size" = toString font.size;


            "flat_toc" = "0";

            "page_separator_width" = "5";
            "page_separator_color" = t2;

            "case_sensitive_search" = "1";

            "highlight_color_a" = aqua;
            "highlight_color_b" = aqua;
            "highlight_color_c" = aqua;
            "highlight_color_d" = aqua;
            "highlight_color_e" = aqua;
            "highlight_color_f" = aqua;
            "highlight_color_g" = aqua;
            "highlight_color_h" = aqua;
            "highlight_color_i" = aqua;
            "highlight_color_j" = aqua;
            "highlight_color_k" = aqua;
            "highlight_color_l" = aqua;
            "highlight_color_m" = aqua;
            "highlight_color_n" = aqua;
            "highlight_color_o" = aqua;
            "highlight_color_p" = aqua;
            "highlight_color_q" = aqua;
            "highlight_color_r" = aqua;
            "highlight_color_s" = aqua;
            "highlight_color_t" = aqua;
            "highlight_color_u" = aqua;
            "highlight_color_v" = aqua;
            "highlight_color_w" = aqua;
            "highlight_color_x" = aqua;
            "highlight_color_y" = aqua;
            "highlight_color_z" = aqua;
        };

        bindings = {
            "goto_beginning" = "g";
            "goto_end" = "G";

            "goto_left_smart" = "^";
            "goto_right_smart" = "$";

            "move_right" = "n";
            "move_up" = "a";
            "move_down" = "i";
            "move_left" = "o";

            "next_page" = "I";
            "previous_page" = "A";

            "close_window" = ";";
            "goto_toc" = "t";

            "search" = "/";
            "next_item" = "j";
            "previous_item" = "J";
            "open_link" = "f";

            "zoom_in" = "<tab>";
            "zoom_out" = "u";
            "fit_to_page_width_smart" = "l";
            "fit_to_page_height_smart" = "L";

            "rotate_clockwise" = "r";
            "rotate_counterclockwise" = "R";

            "set_mark" = "m";
            "goto_mark" = "'";

            "copy" = "y";

            "command" = ":";

            "toggle_custom_color" = "V";
            "toggle_highlight" = "<C-v>";

            "keyboard_select" = "v";
        };
    };
}
