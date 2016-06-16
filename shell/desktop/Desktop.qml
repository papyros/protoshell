import QtQuick 2.0
import Material 0.3
import "../base"
import "../panel"
import "../notifications"

BaseDesktop {
    id: desktop

    property alias surfacesArea: workspace.surfacesLayer
    property alias overlayLayer: desktopOverlayLayer

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

    function updateTooltip(item, containsMouse) {
        if (containsMouse) {
            if (item.tooltip) {
                tooltip.text = Qt.binding(function() { return item.tooltip })
                tooltip.open(item, 0, dp(16))
            }
        } else if (tooltip.showing) {
            tooltip.close()
        }
    }

    Tooltip {
        id: tooltip
        overlayLayer: "desktopTooltipOverlayLayer"
    }

    Workspace { id: workspace }

    NotificationsView { id: notificationsView }

    OverlayLayer {
        id: desktopOverlayLayer
        objectName: "desktopOverlayLayer"

        // FIXME: shell
        // onCurrentOverlayChanged: {
        //     if (currentOverlay && shell.state !== "default" && shell.state !== "locked")
        //         shell.state = "default"
        // }
    }

    OverlayLayer {
        id: tooltipOverlayLayer
        objectName: "desktopTooltipOverlayLayer"
        enabled: desktopOverlayLayer.currentOverlay == null
    }

    Panel { id: panel }
}
