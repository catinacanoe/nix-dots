{ rice, hostname, ... }: let
    defwindow = m: /* yuck */ ''
        (defwindow dock-${toString m.priority}
            :monitor "${m.name}"
            :geometry (geometry :x "0px"
                                :y "${toString (rice.window.gaps-out + rice.window.border)}px"
                                :width "${toString (m.width / m.scale - 2*(rice.window.gaps-out + rice.window.border))}px"
                                :height "${toString rice.bar.height}px"
                                :anchor "top center")
            :exclusive true
            :windowtype "dock"
            :stacking "fg"
            :wm-ignore false
            (dock_layout :mon ${toString m.priority})
        )
        
    '';
in /* yuck */ ''
${defwindow rice.monitor.primary}
${defwindow rice.monitor.secondary}

(defvar var_hostname "${hostname}")

${builtins.readFile ./yuck.yuck}
''
