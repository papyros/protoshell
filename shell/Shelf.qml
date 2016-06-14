import QtQuick 2.6
import QtQuick.Window 2.2
import Material 0.3
import org.kde.kquickcontrolsaddons 2.0
import io.papyros.shell 0.1

Item {
    anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
    }

    width: row.width
    height: 64

    LauncherModel {
        id: applications
        applicationManager: compositor.applicationManager
    }

    Row {
        id: row
        spacing: 16
        anchors.centerIn: parent

        Repeater {
            model: applications

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

                    icon: desktopFile.iconName

                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
