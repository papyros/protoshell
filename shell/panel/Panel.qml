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
import Papyros.Desktop 0.1
import Papyros.Components 0.1
import Papyros.Indicators 0.1

import "../launcher"
import "../desktop"

View {
    id: panel

    property bool showing: desktop.state == "session"

    property color darkColor: "#263238"
    property bool maximized: desktop.hasMaximizedWindow ||
            !ShellSettings.appShelf.transparentShelf

    backgroundColor: Theme.alpha("#263238", maximized ? 1 : 0)
    height: dp(56)
    clipContent: false

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        bottomMargin: showing ? 0 : -height

        Behavior on bottomMargin {
            NumberAnimation {
                duration: 500
                easing.type: Easing.InOutCubic 
            }
        }
    }

    // FIXME
    // Connections {
    //     target: shell
    //
    //     onSuperPressed: appDrawerButton.toggle()
    // }

    RowLayout {
        anchors {
            left: parent.left
            right: indicatorsRow.left
            top: parent.top
            bottom: parent.bottom
        }

        spacing: 0

        Item {
            height: parent.height
            Layout.preferredWidth: height

            View {
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: dp(8)
                }

                width: height

                elevation: panel.maximized ? 0 : 2
                radius: dp(2)
                backgroundColor: panel.darkColor

                IndicatorView {
                    id: appDrawerButton

                    anchors.centerIn: parent

                    width: height
                    iconSize: dp(24)
                    indicator: AppDrawer {
                        id: appDrawer
                    }
                }
            }
        }

        AppsRow {}
    }

    View {
        id: indicatorsRow

        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            margins: dp(8)
        }

        elevation: panel.maximized ? 0 : 2
        radius: dp(2)
        backgroundColor: panel.darkColor

        width: row.implicitWidth + dp(16)
        clipContent: false

        Row {
            id: row

            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                leftMargin: dp(8)
                rightMargin: dp(8)
                margins: panel.maximized ? dp(-8) : 0
            }

            IndicatorView {
                indicator: DateTimeIndicator {}
            }

            Repeater {
                model: compositor.indicators
                delegate: IndicatorView {
                    indicator: modelData
                }
            }
        }
    }

    WindowTooltip {
        id: windowPreview
        overlayLayer: "desktopTooltipOverlayLayer"
    }
}
