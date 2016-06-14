import QtQuick 2.0
import "base"

BaseDesktop {
    property alias surfacesArea: surfacesLayer

    Image {
        id: backgroundLayer

        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop
        source: "/usr/share/wallpapers/Next/contents/images/1440x900.png"
    }

    Item {
        id: surfacesLayer

        anchors.fill: parent
    }

    Panel {}
    Shelf {}
}
