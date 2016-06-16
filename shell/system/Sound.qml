import QtQuick 2.0
import Papyros.Desktop 0.1

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
