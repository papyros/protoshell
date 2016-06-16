import QtQuick 2.0
import Material 0.3
import "../panel"

MaterialDesktop {
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

    OverlayLayer {
        id: desktopOverlayLayer
        objectName: "desktopOverlayLayer"
    }

    Panel { id: panel }
}
