import QtQuick 2.0

Grid {
    columns: 3
    spacing: iconSize/5

    property color lightColor: Qt.rgba(1,1,1,0.40)
    property color mediumColor: Qt.rgba(1,1,1,0.70)
    property color darkColor: Qt.rgba(1,1,1,1)

    Dot { color: lightColor }
    Dot { color: mediumColor }
    Dot { color: lightColor }

    Dot { color: mediumColor }
    Dot { color: darkColor }
    Dot { color: mediumColor }

    Dot { color: lightColor }
    Dot { color: mediumColor }
    Dot { color: lightColor }
}
