import QtQuick 2.0
import "base"

BaseDesktop {
    property alias surfacesArea: surfacesLayer

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
        'top': panel.height,
        'bottom': 0
    }

    Image {
        id: backgroundLayer

        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop
        source: "/usr/share/wallpapers/Next/contents/images/1440x900.png"
    }

    Item {
        id: surfacesLayer

        anchors.fill: parent
        anchors.topMargin: panel.height
    }

    Panel { id: panel }
    Shelf {}
}
