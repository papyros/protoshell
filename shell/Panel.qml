import QtQuick 2.6
import QtQuick.Layouts 1.3
import Material 0.3

Item {
    id: panel

    height: 36
    width: parent.width

    property int iconSize: 18

    RowLayout {
        anchors {
            fill: parent
            margins: (panel.height - iconSize)/2
        }

        spacing: anchors.margins

        Repeater {
            model: ["communication_email", "communication_message", "communication_call", "action_alarm"]

            delegate: Icon {
                source:  Qt.resolvedUrl("icons/%1.svg".arg(modelData))
                color: Theme.dark.iconColor
                size: iconSize
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Label {
            color: Theme.dark.textColor
            text: "Sun 8:48 PM"
        }

        Repeater {
            model: ["device_network_wifi", "av_volume_down", "device_battery_charging_full", "action_power_settings_new"]

            delegate: Icon {
                source:  Qt.resolvedUrl("icons/%1.svg".arg(modelData))
                color: Theme.dark.iconColor
                size: iconSize
            }
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 4

        Rectangle {
            width: 6
            height: width
            radius: width/2
            color: "white"
        }

        Rectangle {
            width: 6
            height: width
            radius: width/2
            color: "white"
            opacity: 0.5
        }

        Rectangle {
            width: 6
            height: width
            radius: width/2
            color: "white"
            opacity: 0.5
        }
    }
}
