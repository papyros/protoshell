import QtQuick 2.6
import QtQuick.Window 2.2
import Material 0.3
import org.kde.kquickcontrolsaddons 2.0

Item {
    anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
    }

    width: row.width
    height: 64

    Row {
        id: row
        spacing: 16
        anchors.centerIn: parent

        Repeater {
            model: ["system-file-manager", "firefox", "internet-mail", "terminal", "atom", "software-store"]

            delegate: Item {
                width: 48
                height: width

                QIconItem {
                    id: __icon

                    property real ratio: Screen.devicePixelRatio

                    anchors.centerIn: parent

                    scale: 1/ratio
                    width: 48 * ratio
                    height: width

                    icon: modelData

                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
