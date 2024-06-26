{ config, ... }: { xdg.configFile."cadence/conf.toml".text = ''
save_path = "/home/canoe/repos/cadence/run"

[time]
day_start_hour = 6
day_start_minute = 0
day_end_hour = 22
day_end_minute = 0

default_block_minutes = 30

[ui]
target_day_width = 20
target_gap_width = 6

frame_time = 40

    [ui.colors] # white, red, green, yellow, blue, purple, aqua, gray
    relative = 3
    focus = 1
    cursor = 3
    background = 7

    [ui.relative_time]
    yesterday = "Ytdy"
    today = "Today"
    tomorrow = "Tmrw"
    next_week = "Nx Wk"
    last_week = "Ls Wk"
    next_month = "Nx Mon"
    last_month = "Ls Mon"
    next_year = "Nx Yr"
    last_year = "Ls Yr"

    [ui.date_formats]
    date_format = "%d.%m"
    day_format = "%a"
    hour_format = "%H:%M"
    parse_format = "%H:%M~%d.%m.%Y"

    [ui.boxdrawing]
    highlight_fill = "╱"

    normal_tl = "┌"
    normal_tr = "┐"
    normal_bl = "└"
    normal_br = "┘"
    normal_hz = "─"
    normal_vr = "│"
    normal_fill = " "

    important_tl = "╔"
    important_tr = "╗"
    important_bl = "╚"
    important_br = "╝"
    important_hz = "═"
    important_vr = "║"
    important_fill = " "

    background_tl = "┆"
    background_tr = "┆"
    background_bl = "┆"
    background_br = "┆"
    background_hz = " "
    background_vr = "┆"
    background_fill = " "

[keybinds]
timeout = 500

left = "n"
up = "a"
down = "i"
right = "o"

quit = ";n"

    [keybinds.week]
    follow_link = "e"
    open_source_file = "h"

    rename = "m"
    confirm_rename = "<cr>"
    cancel_rename = ";n"
    clear_rename = "<left>"

    undo = "u"
    redo = "U"

    remove = "r"
    new_block_below = "l"
    new_block_above = "L"
    enter_highlight_mode = "v"

    move_left = "N"
    move_up = "A"
    move_down = "I"
    move_right = "O"

    extend_top_up = "<left>"
    extend_top_down = "<right>"
    extend_bottom_up = "<up>"
    extend_bottom_down = "<down>"

    # move_up_snap = ","
    # move_down_snap = ":"

    # extend_top_up_snap = "w"
    # extend_top_down_snap = "'"
    # extend_bottom_up_snap = "."
    # extend_bottom_down_snap = ";"

        [keybinds.week.highlight_mode]

        highlight = "v"
        highlight_group = "g"
        exit_mode = ";n"
''; }
