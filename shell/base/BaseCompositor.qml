/****************************************************************************
 * This file is part of Hawaii.
 *
 * Copyright (C) 2012-2016 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL2+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0
import GreenIsland 1.0 as GreenIsland

GreenIsland.WaylandCompositor {
    id: compositor

    property Component desktopComponent
    property Component idleDimmerComponent
    property Component outputComponent: BaseOutput {
        desktopComponent: compositor.desktopComponent
        idleDimmerComponent: compositor.idleDimmerComponent
    }

    property int idleDelay

    readonly property alias outputs: __private.outputs
    readonly property alias primaryScreen: screenManager.primaryScreen

    property int idleInhibit: 0
    property bool isIdle: false

    readonly property alias windowsModel: windowsModel
    readonly property alias applicationManager: applicationManager

    function wake() {
        var i;
        for (i = 0; i < __private.outputs.length; i++) {
            idleTimer.restart();
            __private.outputs[i].wake();
        }

        isIdle = false;
    }

    function idle() {
        var i;
        for (i = 0; i < __private.outputs.length; i++)
            __private.outputs[i].idle();

        isIdle = true;
    }

    extensions: [
        GreenIsland.QtWindowManager {
            showIsFullScreen: false
        },
        GreenIsland.WlShell {
            onShellSurfaceCreated: {
                var window = windowManager.createWindow(shellSurface.surface);
                windowsModel.append({"window": window});

                var i, view;
                for (i = 0; i < __private.outputs.length; i++) {
                    view = chromeComponent.createObject(__private.outputs[i].surfacesArea, {"shellSurface": shellSurface, "window": window});
                    view.moveItem = window.moveItem;
                    window.addWindowView(view);
                }
            }
        },
        GreenIsland.XdgShell {
            onXdgSurfaceCreated: {
                var window = windowManager.createWindow(xdgSurface.surface);
                windowsModel.append({"window": window});

                var i, view;
                for (i = 0; i < __private.outputs.length; i++) {
                    view = chromeComponent.createObject(__private.outputs[i].surfacesArea, {"shellSurface": xdgSurface, "window": window});
                    view.moveItem = window.moveItem;
                    window.addWindowView(view);
                }
            }
        },
        GreenIsland.TextInputManager {},
        GreenIsland.ApplicationManager {
            id: applicationManager
        },
        GreenIsland.OutputManagement {
            id: outputManagement
            onCreateOutputConfiguration: {
                var outputConfiguration = outputConfigurationComponent.createObject();
                outputConfiguration.initialize(outputManagement, resource);
            }
        },
        GreenIsland.Screencaster {
            id: screencaster
        },
        GreenIsland.Screenshooter {
            id: screenshooter

            onCaptureRequested: {
                // TODO: We might want to do something depending on the capture type - plfiorini
                switch (screenshot.captureType) {
                case GreenIsland.Screenshot.CaptureActiveWindow:
                case GreenIsland.Screenshot.CaptureWindow:
                case GreenIsland.Screenshot.CaptureArea:
                    break;
                default:
                    break;
                }

                // Setup client buffer
                screenshot.setup();
            }
        }
    ]

    onCreateSurface: {
        var surface = surfaceComponent.createObject(compositor, {});
        surface.initialize(compositor, client, id, version);
    }

    QtObject {
        id: __private

        property variant outputs: []
    }

    // Screen manager
    GreenIsland.ScreenManager {
        id: screenManager

        onScreenAdded: {
            var view = outputComponent.createObject(
                        compositor, {
                            "compositor": compositor,
                            "nativeScreen": screen
                        });
            __private.outputs.push(view);
        }

        onScreenRemoved: {
            var index = screenManager.indexOf(screen);
            if (index < __private.outputs.length) {
                var output = __private.outputs[index];
                __private.outputs.splice(index, 1);
                output.destroy();
            }
        }

        onPrimaryScreenChanged: {
            var index = screenManager.indexOf(screen);
            if (index < __private.outputs.length) {
                console.debug("Setting screen", index, "as primary");
                compositor.defaultOutput = __private.outputs[index];
            }
        }
    }

    // Idle manager
    Timer {
        id: idleTimer

        interval: idleDelay * 1000
        running: true
        repeat: true

        onTriggered: {
            var i, output, idleHint = false;
            for (i = 0; i < __private.outputs.length; i++) {
                output = __private.outputs[i];
                if (idleInhibit + output.idleInhibit == 0) {
                    output.idle();
                    idleHint = true;
                }
            }

            isIdle = idleHint;
        }
    }

    // Windows
    ListModel {
        id: windowsModel
    }

    // Window manager
    GreenIsland.WindowManager {
        id: windowManager
        compositor: compositor
    }

    // Surface component
    Component {
        id: surfaceComponent

        GreenIsland.WaylandSurface {}
    }

    // Window component
    Component {
        id: chromeComponent

        GreenIsland.WindowChrome {}
    }

    Component {
        id: outputConfiguration

        OutputConfiguration {}
    }
}
