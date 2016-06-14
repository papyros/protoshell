import QtQuick 2.0
import Material 0.3
import io.papyros.shell 0.1
import "base"

BaseCompositor {
    id: compositor

    desktopComponent: Desktop {}

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
}
