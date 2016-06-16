import QtQuick 2.0
import Material 0.3
import Papyros.Desktop 0.1
import Papyros.Indicators 0.1
import org.kde.kcoreaddons 1.0 as KCoreAddons
import "base"
import "desktop"
import "system"

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

        Component.onCompleted: updateSettings()

        onValueChanged: updateSettings()

        function updateSettings() {
            Theme.accentColor = Palette.colors[ShellSettings.desktop.accentColor]['500']
            DesktopFiles.iconTheme = ShellSettings.desktop.iconTheme
        }
    }

    Component.onCompleted: {
        Theme.primaryColor = Palette.colors['blue']['500']
        Theme.iconsRoot = Qt.resolvedUrl('icons')
    }

    KCoreAddons.KUser { id: currentUser }
    MprisConnection { id: musicPlayer }
    Sound { id: sound }
    HardwareEngine { id: hardware }
    NotificationServer { id: notifyServer }
    DateTime { id: dateTime }
}
