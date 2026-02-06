{ config, inputs, pkgs, ... }@args:
let
    lib = inputs.home-manager.lib;

    rice = (import ../../rice);
    col = rice.col; 
    window = rice.window;
    pypr = (import ./pyprland.nix args);

    host = import ../../ignore-hostname.nix;

    maincol = "rgba(${col.fg.hex}b0)";
    altcol = "rgba(00000000)";
    strip = "${maincol} ${maincol} ${altcol}";
    gradient = "${strip} ${strip} ${strip} 45deg";

    monitor-specs = mon: pos: "${toString mon.width}x${toString mon.height}@${toString mon.fps}, ${pos}, ${toString mon.scale}";
in {
    home.activation.hyprland = lib.hm.dag.entryAfter ["onFilesChange"]
        "$DRY_RUN_CMD ${pkgs.hyprland}/bin/hyprctl reload > /dev/null";

    home.activation.pyprland = lib.hm.dag.entryAfter ["onFilesChange"]
        pypr.activation;

    xdg.configFile."hypr/pyprland.toml" = pypr.pypr;

    wayland.windowManager.hyprland.extraConfig = /* hyprlang */ ''

    ${if host == "nixbox" then ''
    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = WLR_NO_HARDWARE_CURSORS,1
    env = WLR_DRM_NO_ATOMIC,1
    '' else ""}

    exec-once = mpd && mpc volume 70 && mpc repeat on && mpc random off && mpc single off && mpc crossfade 1
    exec-once = drop init
    exec-once = kitty
    exec-once = pypr

    exec = sleep 7 && ${config.xdg.configHome}/eww/init.sh
    exec = sleep 1 && swww-daemon
    exec = killall .libinput-gestures-wrapped ; libinput-gestures

    # cursor
    exec-once = hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}
    env = XCURSOR_SIZE,${toString config.home.pointerCursor.size} # affected by scale (i think)

    # gtk-layer-shell is the 'namespace' (see `hyprctl layers`)
    # that contains the eww bar
    layerrule = ignorezero, gtk-layer-shell # ensures transparent pixels are not blurred
    layerrule = blur, gtk-layer-shell # blurs the bar

    # window rules to make rofi always floating and stuff
    # or to set window opacity
    # idle inhibit, (youtube windows for example)

    windowrulev2 = opacity 0.90 0.90, class:^(${config.home.sessionVariables.TERMINAL})$
    windowrulev2 = opacity 0.95 1.00, class:^(Spotify)$
    # windowrulev2 = opacity 1.0 override 0.9 override, class:^(${config.home.sessionVariables.BROWSER})$
    # windowrulev2 = opacity 1.0 override 1.0 override, class:^(imv)$
    # windowrulev2 = opacity 1.0 override 1.0 override, class:^(mpv)$

    windowrulev2 = float,class:^(scratchpad)$
    windowrulev2 = workspace special silent,class:^(scratchpad)$

    windowrulev2 = float,class:^(Spotify)$
    windowrulev2 = workspace special silent,class:^(Spotify)$

    # bind=mods, key, dispatcher, args | unbind=mods, key
    # can use code:## for key
    # bindl=,switch:[switch name],exec,swaylock # see wiki, bind#switches
    # use pass dispatcher to pass binds to certain apps # see wiki

    bezier=linear, 1, 1, 0, 0
    bezier=easeout, 0.25, 1, 0.5, 1

    debug {
        disable_logs = false
        enable_stdout_logs = true
    }

    general {
        # defaults
        border_size = ${toString window.border}
        gaps_in = ${toString window.gaps-in}
        gaps_out = ${toString window.gaps-out}

        col.inactive_border = rgba(00000000)
        col.nogroup_border = rgba(00000000)
        col.active_border         = ${gradient}
        col.nogroup_border_active = ${gradient}

        layout = dwindle

        no_focus_fallback = true # don't wrap around when moving focus into a wall
    }#general

    cursor {
        inactive_timeout = 30
    }#cursor

    decoration {
        # defaults
        # drop shadow (see wiki)
        # dim inactive windows (see wiki)
        # screen_shader (custom shader to apply @ end of pipeline)
        rounding = ${toString window.radius}
        fullscreen_opacity = 1.0
        active_opacity = 1.0
        inactive_opacity = 0.9
        shadow {
            enabled = false
        }#shadow

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

        animation = windowsIn, 1,   5, easeout, slide # spawning
        animation = windowsOut, 1,  2, linear,  slide # closing
        animation = windowsMove, 1, 4, easeout, slide # resizing dragging moving
        animation = fadeIn, 1,      5, easeout # fade on opening stuff
        animation = fadeOut, 1,     2, linear  # fade on closing stuff
        animation = fadeSwitch, 1,  7, easeout # fade on changing focus
        animation = border, 1,      7,   easeout      # border color changes
        animation = borderangle, 1, 100, linear, loop # changing the gradient angle
        animation = workspaces, 1,       4, easeout, slidefade 15%
        animation = specialWorkspace, 1, 5, easeout, slidevert
    }#animations

    # per device input settings exist (see wiki)
    input {
        # defaults
        natural_scroll = false
        follow_mouse = 1 # (0-3) see wiki (1 is intuitive enable)
        mouse_refocus = true # see wiki (only relevant if follow_mouse = 1)
	# this is needed if mouse does not warp on spawn

        numlock_by_default = true # who uses numpad for navigation anyways
      
        repeat_rate = 60
        repeat_delay = 160
        sensitivity = 0.8 # (-1 - 1)
        accel_profile = flat # {adaptive, flat, custom} unset=>defers to libinput

        touchpad {
            scroll_factor = 0.4
            disable_while_typing = false
        }#touchpad
    }#input

    ${let
    model-o = suffix: /* hyprlang */ ''
    device {
        name=glorious-model-o-wireless${suffix}
        sensitivity=-0.2
        accel_profile=flat
    }
    '';
    in ''
    ${model-o ""}
    ${model-o "-1"}
    ''}

    gestures {
        workspace_swipe_use_r = true
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
        focus_on_activate = true
        # allow_session_lock_restore = false # restore locking apps
  
        enable_swallow = true
        swallow_regex = ^(kitty)$ # class
        #swallow_exception_regex = ^(*dragon*)$ # title # this completely removes swallowing :/

        disable_autoreload = true
        disable_splash_rendering = true
        new_window_takes_over_fullscreen = 2 # opening app when in flscrn exits flscrn
    }#misc

    binds {
        movefocus_cycles_fullscreen = false # not sure about this one
        workspace_center_on = 1 # mouse over the last active window when switching wspc
        focus_preferred_method = 0 # (0-history, 1-shared border length)
        allow_workspace_cycles = true
    }

    xwayland {
        # defaults
        # use_nearest_neighbor = true # (T-pixelated F-blurry) (irrelevant if f_z_s=T)

        force_zero_scaling = true # remove scaling, clearer image
    }
    # env gdk scale see xwayland hyprland wiki

    # exec-once = _, exec = _
    # $var = val
    # sys.setting = 0x-$var
    # source = ~/my.conf
    # layerrule

    # name, res@fps, pos of monitor's TpLft corner in layout, scale
    # position is calculated WITH the scaled & transformed resolution
    # use ,transform to rotate, see wiki

    # bind ws ranges to monitors
    workspace = 1, monitor:${rice.monitor.primary.port}, default:true, persistent:true
    workspace = r[1-8], monitor:${rice.monitor.primary.port}

    ${if host == "nixbox" then let m = rice.monitor; in ''
    monitor = ${m.primary.port}, ${monitor-specs m.primary "0x0"}
    ''
    else if host == "nixpad" then let m = rice.monitor; in ''
    monitor = ${m.primary.port}, ${monitor-specs m.primary "${toString (-m.primary.width / m.primary.scale)}x${toString (-m.primary.height / m.primary.scale)}"}
    monitor = ${m.secondary.port}, ${monitor-specs m.secondary "0x${toString (-m.secondary.height / m.secondary.scale)}"}

    workspace = 11, monitor:${rice.monitor.secondary.port}, default:true, persistent:true
    workspace = r[11-18], monitor:${rice.monitor.secondary.port}
    ''
    else ""}

    monitor=,preferred,auto,1 # auto rule for random monitors

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
    '';
}
