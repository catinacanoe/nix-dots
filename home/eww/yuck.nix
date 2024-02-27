{ rice, hostname, ... }: /* yuck */ ''
(defwindow dock
    :monitor 0
    :geometry (geometry :x "0px"
                        :y "${toString (rice.window.gaps-out + rice.window.border)}px"
                        :width "${toString (rice.monitor.width / rice.monitor.scale - 2*(rice.window.gaps-out + rice.window.border))}px"
                        :height "35px"
                        :anchor "top center")
    :exclusive true
    :windowtype "dock"
    :stacking "fg"
    :wm-ignore false
    (dock_layout)
)

(defvar laptop ${if hostname == "nixpad" then "true" else "false"})

${builtins.readFile ./yuck.yuck}
''
