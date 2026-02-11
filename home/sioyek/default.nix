{ config, ... }:
with (import ../../rice);
with col;
{
    programs.sioyek = {
        enable = true;

        config = {
            "startup_commands" = "toggle_custom_color";
            "should_launch_new_window" = "1";
            "collapsed_toc" = "1";

            "background_color" = bg.rgb0;
            "custom_background_color" = bg.rgb0;
            "custom_text_color" = fg.rgb0;


            "text_highlight_color" = blue.rgb0;
            "search_highlight_color" = yellow.rgb0;
            "link_highlight_color" = blue.rgb0;
            "synctex_highlight_color" = blue.rgb0;


            "ui_font" = font.full.family;
            "font_size" = toString font.size;

            "ui_background_color" = bg.rgb0;
            "ui_text_color" = fg.rgb0;

            "ui_selected_background_color" = purple.rgb0;
            "ui_selected_text_color" = bg.rgb0;


            "status_bar_color" = t1.rgb0;
            "status_bar_text_color" = fg.rgb0;
            "status_bar_font_size" = toString font.size;


            "flat_toc" = "0";

            "page_separator_width" = "5";
            "page_separator_color" = t2.rgb0;

            "case_sensitive_search" = "1";

            "highlight_color_r" = red.rgb0;
            "highlight_color_o" = orange.rgb0;
            "highlight_color_y" = yellow.rgb0;
            "highlight_color_g" = green.rgb0;
            "highlight_color_a" = aqua.rgb0;
            "highlight_color_b" = blue.rgb0;
            "highlight_color_p" = purple.rgb0;
            "highlight_color_w" = fg.rgb0;

            "highlight_color_c" = aqua.rgb0;
            "highlight_color_d" = aqua.rgb0;
            "highlight_color_e" = aqua.rgb0;
            "highlight_color_f" = aqua.rgb0;
            "highlight_color_h" = aqua.rgb0;
            "highlight_color_i" = aqua.rgb0;
            "highlight_color_j" = aqua.rgb0;
            "highlight_color_k" = aqua.rgb0;
            "highlight_color_l" = aqua.rgb0;
            "highlight_color_m" = aqua.rgb0;
            "highlight_color_n" = aqua.rgb0;
            "highlight_color_q" = aqua.rgb0;
            "highlight_color_s" = aqua.rgb0;
            "highlight_color_t" = aqua.rgb0;
            "highlight_color_u" = aqua.rgb0;
            "highlight_color_v" = aqua.rgb0;
            "highlight_color_x" = aqua.rgb0;
            "highlight_color_z" = aqua.rgb0;
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
