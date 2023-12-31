{ config, inputs, pkgs, ... }:
let
    lib = inputs.home-manager.lib;

    rice = (import ../../rice);
    col = rice.col; 
    window = rice.window;

    gradient = "rgba(${col.fg}b0) rgba(00000000) rgba(${col.fg}b0) rgba(00000000) 45deg";
in
{
    home.activation.hyprland = lib.hm.dag.entryAfter ["onFilesChange"]
        "$DRY_RUN_CMD ${pkgs.hyprland}/bin/hyprctl reload > /dev/null";

    wayland.windowManager.hyprland.extraConfig = /* bash */ ''
    exec-once = kitty
    exec-once = swww init
    exec-once = waybar

    #windowrulev2 = opacity 1.0 override 1.0, title:^(.*)( - YouTube)(.*)$,class:^(firefox)$
    #windowrulev2 = opacity 1.0 override 1.0, title:^(Mozilla Firefox)$,class^(firefox)$
    #windowrulev2 = opacity 1.0 1.0, title:^(?!.*( - Youtube|Mozilla Firefox)),class^(firefox)$

    # bind=mods, key, dispatcher, args | unbind=mods, key
    # can use code:## for key
    # bindl=,switch:[switch name],exec,swaylock # see wiki, bind#switches
    # use pass dispatcher to pass binds to certain apps # see wiki

    bezier=linear, 1, 1, 0, 0
    bezier=easeout, 0.25, 1, 0.5, 1

    general {
        # defaults
        # no_cursor_warps = false # allow cursor to be moved by refocus
        border_size = ${toString window.border}
        gaps_in = ${toString window.gaps-in}
        gaps_out = ${toString window.gaps-out}

        col.inactive_border = rgba(00000000)
        col.nogroup_border = rgba(00000000)
        col.active_border         = ${gradient}
        col.nogroup_border_active = ${gradient}

        cursor_inactive_timeout = 30
        layout = dwindle

        no_focus_fallback = true # don't wrap around when moving focus into a wall
    }#general

    decoration {
        # defaults
        # drop shadow (see wiki)
        # dim inactive windows (see wiki)
        # screen_shader (custom shader to apply @ end of pipeline)
        rounding = ${toString window.radius}
        fullscreen_opacity = 1.0
        active_opacity = 0.9
        inactive_opacity = 0.8
        drop_shadow = false

        blur {
            # defaults
            # special = false # blur behind special wkspace (expensive)
            enabled = true
            ignore_opacity = true

            size = 5
            passes = 3

            noise = 0.02 # (0-1)
            contrast = 0.9 # (0-2)
            brightness = 0.8 # (0-2)
            vibrancy = 0.17 # (0-1) saturation
            vibrancy_darkness = 0.1 # (0-1) effect of saturation on dark spots
        }#blur
    }#decoration

    animations {
        enabled = true

        animation = windowsIn,1,   5, easeout, slide # spawning
        animation = windowsOut,1,  2, linear,  slide # closing
        animation = windowsMove,1, 4, easeout, slide # resizing dragging moving
        animation = fadeIn,1,      5, easeout # fade on opening stuff
        animation = fadeOut,1,     2, linear  # fade on closing stuff
        animation = fadeSwitch,1,  7, easeout # fade on changing focus
        animation = border,1,      7,   easeout      # border color changes
        animation = borderangle,1, 100, linear, loop # changing the gradient angle
        animation = workspaces,1,       4, easeout, slidefade 15%
        animation = specialWorkspace,1, 5, easeout, slidevert
    }#animations

    # per device input settings exist (see wiki)
    input {
        # defaults
        # natural_scroll = false
        # follow_mouse = 1 # (0-3) see wiki (1 is intuitive enable)
        mouse_refocus = false # see wiki (only relevant if follow_mouse = 1)
	# this is needed if mouse does not warp on spawn

        numlock_by_default = true # who uses numpad for navigation anyways
      
        repeat_rate = 60
        repeat_delay = 160
        sensitivity = 0.35 # (-1 - 1)
        accel_profile = flat # {adaptive, flat, custom} unset=>defers to libinput

        touchpad {
            scroll_factor = 0.4
        }#touchpad
    }#input

    gestures {
        # workspace_swipe_numbered = false
        # workspace_swipe_use_r = false # see wiki
        workspace_swipe = true
        workspace_swipe_distance = 700 # basically just sens
        workspace_swipe_min_speed_to_force = 10 # force switch @ speed
        workspace_swipe_cancel_ratio = 0.3 # min amount of screen to cover
        workspace_swipe_direction_lock = false # change direction anytime
    }#gestures

    misc {
        # defaults
        force_default_wallpaper = 0 # set to 0 once we add our own

        animate_manual_resizes = true
        # allow_session_lock_restore = false # restore locking apps
  
        enable_swallow = true
        swallow_regex = ^(kitty)$ # class
        #swallow_exception_regex = ^(*dragon*)$ # title # this completely removes swallowing :/

        disable_autoreload = true
        disable_splash_rendering = true
        new_window_takes_over_fullscreen = 2 # opening app when in flscrn exits flscrn
    }#misc

    binds {
        # defaults
        # movefocus_cycles_fullscreen = true # not sure about this one

        workspace_center_on = 1 # mouse over the last active window when switching wspc
        focus_preferred_method = 0 # (0-history, 1-shared border length)
    }

    xwayland {
        # defaults
        # use_nearest_neighbor = true # (T-pixelated F-blurry) (irrelevant if f_z_s=T)

        force_zero_scaling = true # remove scaling, clearer image
    }
    env = XCURSOR_SIZE,24 # affected by scale (i think)
    # env gdk scale see xwayland hyprland wiki

    # exec-once = _, exec = _
    # $var = val
    # sys.setting = 0x-$var
    # source = ~/my.conf
    # layerrule

    # name, res@fps, pos of monitor's TpLft corner in layout, scale
    # position is calculated WITH the scaled & transformed resolution
    # use ,transform to rotate, see wiki
    monitor=eDP-1, 2560x1600@60, 0x0, 1.333333
    monitor=,preferred,auto,1 # auto rule for random monitors

    # window rules to make rofi always floating and stuff
    # or to set window opacity
    # idle inhibit, (youtube windows for example)

    dwindle {
        force_split = 0 # 0-follow mouse 1-topleft 2-botright
        preserve_split = true

        # smart_resizing = true # might affect resize keybinds
        permanent_direction_override = true
        default_split_ratio = 1.1

        # hyprctl dispatch layoutmsg preselect l,d,u,r
        # hyprctl dispatch layoutmsg togglesplit
    }

    # hyprctl output create headless (see wiki)

    plugin:hyprfocus {
        enabled = yes

        keyboard_focus_animation = shrink
        mouse_focus_animation = shrink

        shrink {
            shrink_percentage = 1.015
    
            in_bezier = easeout
            in_speed = 0.7

            out_bezier = linear
            out_speed = 1
        }
    }
    '';
}
