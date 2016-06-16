import QtQuick 2.0
import Material 0.3
import "../base"

BaseDesktop {
    OverlayLayer {
        id: dialogOverlayLayer
        objectName: "dialogOverlayLayer"
        z: 100
    }

    OverlayLayer {
        id: tooltipOverlayLayer
        objectName: "tooltipOverlayLayer"
        z: 100
    }

    OverlayLayer {
        id: overlayLayer
        z: 100
    }
}
