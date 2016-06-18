/*
 * Papyros Shell - The desktop shell for Papyros following Material Design
 * Copyright (C) 2015 Michael Spencer
 *               2015 Bogdan Cuza
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

import QtQuick 2.0
import QtQuick.Layouts 1.2
import Material 0.2
import Material.ListItems 0.1 as ListItem
import Papyros.Components 0.1
import Papyros.Desktop 0.1
import Papyros.Indicators 0.1

Indicator {
    id: appDrawer

    iconView: AppsIcon {}
    tooltip: "Applications"

    view: FocusScope {
        implicitHeight: container.height + dp(95 * 4) + dp(48)
        implicitWidth: dp(95 * 4) + dp(16)

        Component.onCompleted: textField.forceActiveFocus()

        Rectangle {
            anchors.fill: parent
            color: "#f6f6f6"
            radius: dp(2)
        }

        Rectangle {
            id: container

            radius: dp(2)
            width: parent.width
            height: dp(48)

            View {
                anchors {
                    topMargin: parent.radius
                    fill: parent
                }
                backgroundColor: "white"
                elevation: 1
            }

            RowLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    leftMargin: dp(16)
                    rightMargin: dp(16)
                }

                spacing: dp(8)

                Icon {
                    Layout.alignment: Qt.AlignVCenter

                    name: "action/search"
                    color: Theme.light.hintColor
                }

                TextField {
                    id: textField

                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true

                    placeholderText: "Search..."
                    showBorder: false
                }
            }
        }

        Column {
            anchors.centerIn: listView
            visible: listView.visible && listView.contentHeight == 0

            spacing: dp(8)

            Icon {
                anchors.horizontalCenter: parent.horizontalCenter
                name: "action/search"
                color: Theme.light.hintColor
                size: dp(48)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "No apps match your search"
                style: "subheading"
                font.pixelSize: dp(18)
                color: Theme.light.hintColor
            }
        }

        ListView {
            id: listView

            anchors {
                left: parent.left
                right: parent.right
                top: container.bottom
                bottom: parent.bottom
            }

            clip: true
            visible: textField.text !== ""

            topMargin: dp(8)
            bottomMargin: dp(8)

            model: DesktopFiles.desktopFiles
            delegate: ListItem.Standard {
                action: AppIcon {
                    iconName: edit.iconName
                    name: edit.name
                    hasIcon: edit.hasIcon
                    anchors.fill: parent
                    asynchronous: true
                }

                text: edit.name
                visible: textField.text === "" ||
                        text.toLowerCase().indexOf(textField.text.toLowerCase()) !== -1
                height: visible ? implicitHeight : 0

                onClicked: {
                    AppLauncherModel.launchApplication(edit.appId)
                    desktop.overlayLayer.currentOverlay.close()
                }
            }
        }

        Scrollbar {
            flickableItem: listView
        }

        PagedGrid {
            id: gridView

            visible: textField.text === ""

            anchors {
                left: parent.left
                right: parent.right
                top: container.bottom
                bottom: parent.bottom
                topMargin: dp(8)
                bottomMargin: dp(40)
                leftMargin: dp(8)
                rightMargin: dp(8)
            }

            rows: 4
            columns: 4

            model: DesktopFiles.desktopFiles

            delegate: AppDrawerDelegate {}
        }

        Row {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: dp(16)
            }

            spacing: dp(16)
            visible: gridView.visible

            Repeater {
                model: gridView.pages
                delegate: Rectangle {
                    color: index == gridView.currentPage
                            ? Theme.dark.accentColor : "#ddd"
                    width: Math.max((gridView.width - gridView.pages * dp(16)) / gridView.pages, height)
                    height: dp(8)
                    radius: height/2

                    MouseArea {
                        anchors.fill: parent

                        onClicked: gridView.currentPage = index
                    }
                }
            }
        }
    }
}
