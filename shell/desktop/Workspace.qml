import QtQuick 2.0

Item {
    property alias surfacesLayer: surfacesLayer

    anchors.fill: parent

    Image {
        id: backgroundLayer

        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop
        source: "/usr/share/wallpapers/Next/contents/images/1440x900.png"
    }

    Item {
        id: surfacesLayer

        anchors.fill: parent
        anchors.bottomMargin: panel.height
    }
}
