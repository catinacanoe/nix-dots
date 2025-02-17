{ rice, hostname, ... }: /* yuck */ ''
(defwindow dock
    :monitor 0
    :geometry (geometry :x "0px"
                        :y "${toString (rice.window.gaps-out + rice.window.border)}px"
                        ;; :width "${toString (rice.monitor.width / rice.monitor.scale - 2*(rice.window.gaps-out + rice.window.border))}px"
                        :width "${toString (rice.monitor.width - 2*(rice.window.gaps-out + rice.window.border))}px"
                        :height "${toString rice.bar.height}px"
                        :anchor "top center")
    :exclusive true
    :windowtype "dock"
    :stacking "fg"
    :wm-ignore false
    (dock_layout)
)

(defvar var_hostname "${hostname}")

${builtins.readFile ./yuck.yuck}
''
