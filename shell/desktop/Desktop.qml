import QtQuick 2.0
import Material 0.3
import "../base"
import "../panel"
import "../notifications"

BaseDesktop {
    id: desktop

    property alias surfacesArea: workspace.surfacesLayer

    property bool hasFullscreenWindow: {
        for (var i = 0; i < windows.length; i++) {
            var window = windows[i]

            if (window.maximized)
                return true
        }

        return false
    }

    insets: {
        'left': 0,
        'right': 0,
        'top': 0,
        'bottom': panel.height
    }

    function dp(dp) {
        return dp * Units.dp
    }

    Workspace { id: workspace }

    NotificationsView { id: notificationsView }

    OverlayLayer {
        id: tooltipOverlayLayer
        objectName: "desktopTooltipOverlayLayer"
        z: 100
        enabled: desktopOverlayLayer.currentOverlay == null
    }

    OverlayLayer {
        id: desktopOverlayLayer
        z: 99
        objectName: "desktopOverlayLayer"

        // FIXME: shell
        // onCurrentOverlayChanged: {
        //     if (currentOverlay && shell.state !== "default" && shell.state !== "locked")
        //         shell.state = "default"
        // }
    }

    Panel { id: panel }
}
