import QtQuick 2.0
import Material 0.3
import "../base"

BaseCompositor {
    desktopComponent: BaseDesktop {
        function dp(dp) {
            return dp * Units.dp
        }

        Rectangle {
            anchors.fill: parent
            color: "#2196f3"
        }

        Wave {
            id: wave
            color:"#f44336"
        }

        Column {
            id: errorView

            anchors.centerIn: parent
            width: parent.width * 0.7

            opacity: wave.opened ? 1 : 0

            Behavior on opacity {
                NumberAnimation { duration: 500 }
            }

            Icon {
                size: dp(100)
                name: "alert/warning"
                color: "white"

                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item {
                width: parent.width
                height: dp(20)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                style: "display1"
                text: "Oh no! "
                color: "white"
            }

            Item {
                width: parent.width
                height: dp(20)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter

                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                wrapMode: Text.Wrap

                style: "title"
                color: "white"

                text: "The desktop failed to materialize"
            }
        }

        Timer {
            interval: 100
            running: true
            onTriggered: wave.open(width/2, height/2)
        }
    }
}
