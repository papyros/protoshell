import QtQuick 2.0
import Material 0.3

Item {
    anchors.fill: parent

    function show() {
        background.open(width/2, height/2)
    }

    function hide() {
        background.close(width/2, height/2)
    }

    Wave {
        id: background

        color: "#2196f3"
        size: diameter
    }

    Column {
        id: welcomeView

        anchors.centerIn: parent

        opacity: desktop.state == "splash" ? 1 : 0
        spacing: dp(15)

        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }

        populate: Transition {
            id: populateTransition
            SequentialAnimation {
                PropertyAction {
                    property: "opacity"; value: 0
                }

                PauseAnimation {
                    duration: (populateTransition.ViewTransition.index -
                            populateTransition.ViewTransition.targetIndexes[0]) * 250 + 100
                }

                ParallelAnimation {
                    NumberAnimation {
                        property: "opacity"; duration: 250
                        from: 0; to: 1
                    }

                    NumberAnimation {
                        property: "y"; duration: 250
                        from: populateTransition.ViewTransition.destination.y + dp(50);
                        easing.type: Easing.OutQuad
                    }
                }
            }
        }

        ProgressCircle {
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter

            style: "display1"
            text: "Welcome"
            color: "white"
        }
    }
}
