import QtQuick 2.0
import Material 0.3
import Papyros.Desktop 0.1
import Papyros.Indicators 0.1
import org.kde.kcoreaddons 1.0 as KCoreAddons
import "base"
import "desktop"

BaseCompositor {
    id: compositor

    desktopComponent: Desktop {}

    property list<Indicator> indicators: [
        StorageIndicator {},
        NetworkIndicator {},
        SoundIndicator {},
        BatteryIndicator {},
        SystemIndicator {}
    ]

    Connections {
        target: ShellSettings.desktop

        Component.onCompleted: {
            Theme.accentColor = Palette.colors[ShellSettings.desktop.accentColor]['500']
            DesktopFiles.iconTheme = ShellSettings.desktop.iconTheme
        }

        onValueChanged: {
            if (key == "accentColor") {
                Theme.accentColor = Palette.colors[ShellSettings.desktop.accentColor]['500']
            } else if (key == "iconTheme") {
                DesktopFiles.iconTheme = ShellSettings.desktop.iconTheme
            }
        }
    }

    Component.onCompleted: Theme.iconsRoot = Qt.resolvedUrl('icons')

    KCoreAddons.KUser {
        id: currentUser
    }

    MprisConnection {
        id: musicPlayer
    }

    Sound {
        id: sound

        property string iconName: sound.muted || sound.master == 0
                ? "av/volume_off"
                : sound.master <= 33 ? "av/volume_mute"
                : sound.master >= 67 ? "av/volume_up"
                : "av/volume_down"

        property int notificationId: 0

        onMasterChanged: {
            soundTimer.restart()
        }

        // The master volume often has random or duplicate change signals, so this helps to
        // smooth out the signals into only real changes
        Timer {
            id: soundTimer
            interval: 10
            onTriggered: {
                if (sound.master !== volume && volume !== -1) {
                    sound.notificationId = notifyServer.notify("Sound", sound.notificationId,
                            "icon://" + sound.iconName, "Volume changed", "", [], {}, 0,
                            sound.master).id
                }
                volume = sound.master
            }

            property int volume: -1
        }
    }

    HardwareEngine {
        id: hardware
    }

    NotificationServer {
        id: notifyServer
    }

    property var now: new Date()

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: now = new Date()
    }
}
