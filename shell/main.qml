import QtQuick 2.6
import Material 0.3

MainView {
    id: shell

    theme {
        primaryColor: "blue"
        accentColor: "blue"
    }

    Desktop {
        anchors.fill: parent
    }
}
