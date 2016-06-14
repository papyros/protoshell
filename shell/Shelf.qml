import QtQuick 2.6
import QtQuick.Window 2.2
import Material 0.3
import io.papyros.shell 0.1
import "components"

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
        includePinnedApplications: true
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

                AppIcon {
                    id: __icon

                    anchors.fill: parent

                    iconName: desktopFile.iconName
                    name: desktopFile.name
                    hasIcon: desktopFile.hasIcon
                }
            }
        }
    }
}
