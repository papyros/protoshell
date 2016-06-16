/*
* Papyros Shell - The desktop shell for Papyros following Material Design
* Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.3
import QtQuick.Layouts 1.0
import Material 0.2
import Material.Extras 0.1
import Papyros.Components 0.1

PanelItem {
    id: indicatorView

    tintColor: containsMouse || selected
            ? defaultColor == Theme.dark.iconColor ? Qt.rgba(0,0,0,0.2) : Qt.rgba(0,0,0,0.1)
            : Qt.rgba(0,0,0,0)

    width: smallMode ? indicator.text ? label.width + (height - label.height) : height
                     : indicator.text ? label.width + (dp(30) - label.height)
                                      : circleImage.visible ? dp(30 * 1.2)
                                                            : dp(30)

    visible: !indicator.hidden && indicator.visible

    property bool smallMode: height < dp(35)
    property Indicator indicator
    property color defaultColor: Theme.dark.iconColor
    property color defaultTextColor: Theme.dark.textColor
    tooltip: indicator ? indicator.tooltip : ""

    property int iconSize: height >= dp(40) ? dp(56) * 0.36 : height * 0.45

    selected: desktop.overlayLayer.currentOverlay == dropdown

    onClicked: toggle()

    function toggle() {
        if (selected)
            dropdown.close()
        else if (indicator.view)
            dropdown.open(indicatorView, 0, dp(16))
    }

    Connections {
        target: indicator
        onClose: desktop.overlayLayer.currentOverlay.close()
    }

    Loader {
        id: iconView
        anchors.centerIn: parent
        sourceComponent: indicator.iconView

        property alias iconSize: indicatorView.iconSize
    }

    Icon {
        anchors.centerIn: parent
        size: iconSize
        source: indicator.iconSource
        color: indicator.color.a == 0 ? defaultColor : indicator.color
        visible: !circleImage.visible && !indicator.iconView
    }

    CircleImage {
        id: circleImage
        anchors.centerIn: parent
        width: iconSize * 1.2
        height: width
        source: visible ? indicator.iconSource : ""
        visible: indicator.circleClipIcon && String(indicator.iconSource).indexOf("icon://") == -1 && !indicator.iconView
    }

    Label {
        id: label
        anchors.centerIn: parent
        text: indicator.text
        color: indicator.color.a == 0 ? defaultTextColor : indicator.color
        font.pixelSize: dp(14)
    }

    Rectangle {
        anchors {
            left: parent.horizontalCenter
            top: parent.verticalCenter
            margins: dp(1)
        }

        color: Palette.colors.red["500"]
        border.color: Palette.colors.red["700"]
        radius: width//dp(1)

        width: dp(10)//Math.min(parent.width/2, Math.max(badgeLabel.width,
                //badgeLabel.height) + dp(2))
        height: width

        visible: indicator.badge !== ""

        // Label {
        //     id: badgeLabel
        //     text: indicator.badge
        //     anchors.centerIn: parent
        //     color: Theme.dark.textColor
        // }
    }

    Popover {
        id: dropdown

        overlayLayer: "desktopOverlayLayer"

        height: content.status == Loader.Ready ? content.implicitHeight : dp(250)
        width: Math.max(content.implicitWidth, dp(300))

        View {
            anchors.fill: parent
            elevation: 2
            radius: dp(2)
        }

        onOpened: {
            content.item.forceActiveFocus()
        }

        Loader {
            id: content
            sourceComponent: indicator.view
            //active: dropdown.showing
            asynchronous: true

            anchors.fill: parent

            function dp(dp) {
                return desktop.dp(dp)
            }
        }
    }
}
