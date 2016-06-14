import QtQuick 2.0
import QtQuick.Window 2.0
import GreenIsland 1.0 as GreenIsland

Window {
    id: window

    property int minKeyboardWidth: 768

    property alias desktop: desktopLoader.item
    property alias idleDimmer: idleLoader.item

    property alias idleDimmerComponent: idleLoader.sourceComponent
    property alias desktopComponent: desktopLoader.sourceComponent

    minimumWidth: 1024
    minimumHeight: 768
    maximumWidth: nativeScreen.width
    maximumHeight: nativeScreen.height

    // Idle dimmer
    Loader {
        id: idleLoader
        anchors.fill: parent
    }

    // Virtual keyboard
    Loader {
        // FIXME: Window doesn't have overlay
        parent: window.overlay
        source: "Keyboard.qml"

        x: (parent.width - width) / 2
        y: parent.height - height
        // TODO: No Fluid UI
        width: Math.max(parent.width / 2, minKeyboardWidth)

        z: 999
    }

    // Keyboard handling
    GreenIsland.KeyEventFilter {
        Keys.onPressed: {
            // Input wakes the output
            compositor.wake();

            desktop.keyPressed(event)
        }

        Keys.onReleased: {
            // Input wakes the output
            compositor.wake();

            desktop.keyReleased(event)
        }
    }

    GreenIsland.WaylandMouseTracker {
        id: localPointerTracker

        anchors.fill: parent
        enableWSCursor: true

        // Input wakes the output
        onMouseXChanged: compositor.wake()
        onMouseYChanged: compositor.wake()

        Loader {
            id: desktopLoader
            anchors.fill: parent
        }

        GreenIsland.WaylandCursorItem {
            id: cursor
            inputDevice: output.compositor.defaultInputDevice
            x: localPointerTracker.mouseX - hotspotX
            y: localPointerTracker.mouseY - hotspotY
            visible: localPointerTracker.containsMouse &&
                     output.powerState === GreenIsland.ExtendedOutput.PowerStateOn
        }
    }
}
