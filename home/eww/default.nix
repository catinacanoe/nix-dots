{ ... }: let rice = (import ../../rice); in {
    xdg.configFile."eww/eww.yuck".text = ''
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

    (defwidget dock_layout []
        (box :orientation "horizontal" :class "dock-layout" (dock_left) (dock_middle) (dock_right))
    )

    (defwidget dock_left []
        (box :orientation "horizontal" :class "dock-left" :hexpand false :halign "start"
            "music stuff"
        )
    )

    (defwidget dock_middle []
        (box :orientation "horizontal" :class "dock-left" :hexpand false :halign "center"
            "workspaces"
        )
    )

    (defwidget dock_right []
        (box :orientation "horizontal" :class "dock-left" :hexpand false :halign "end"
            "time and sys info"
        )
    )
    '';


    xdg.configFile."eww/eww.scss".text = ''
    * {
        all: unset;
    }

    .dock-layout {
        color: ${rice.col.fg.h};
        background: rgba(0, 0, 0, 0)
    }

    .dock-left,
    .dock-middle,
    .dock-right,
    .label {
        border-radius: ${toString rice.window.radius}px;
        background: rgba(${rice.col.bg.rgb}, 0.7);
    }

    .padding {
        background: rgba(0, 0, 0, 0)
    }
    '';
}
