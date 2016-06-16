import QtQuick 2.0
import Material 0.3

Object {
    property var now: new Date()

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: now = new Date()
    }
}
