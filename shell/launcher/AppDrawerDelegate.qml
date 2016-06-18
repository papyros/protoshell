import QtQuick 2.0
import Material 0.3
import Papyros.Components 0.1

Item {
    id: appIcon

    Ink {
        anchors.fill: parent
        onClicked: {
            model.launch([])
            desktop.overlayLayer.currentOverlay.close()
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: dp(8)
        width: parent.width - dp(16)

        AppIcon {
            anchors.horizontalCenter: parent.horizontalCenter
            height: dp(40)
            width: dp(40)
            iconName: model.iconName
            name: model.name
            hasIcon: model.hasIcon
            asynchronous: true
        }

        Label {
            text: model.name
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: dp(30)
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            wrapMode: Text.Wrap
            maximumLineCount: 2
        }
    }
}
