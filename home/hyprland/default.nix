{ ... }: {
    wayland.windowManager.hyprland.extraConfig = /* hyprlang */ ''
        debug {
            disable_logs = false
            gl_debugging = true
            enable_stdout_logs = true
        }
    '';
}
