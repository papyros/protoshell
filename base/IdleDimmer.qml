Rectangle {
    id: blackRect
    parent: window.overlay
    anchors.fill: parent
    color: "black"
    opacity: 0.0
    z: 1000

    onOpacityChanged: {
        if (opacity == 1.0)
            output.powerState = GreenIsland.ExtendedOutput.PowerStateStandby;
    }

    OpacityAnimator {
        id: blackRectAnimator
        target: blackRect
        easing.type: Easing.OutSine
        duration: FluidUi.Units.longDuration
    }

    Timer {
        id: blackRectTimer
        interval: 1000
        onTriggered: {
            blackRectAnimator.from = 1.0;
            blackRectAnimator.to = 0.0;
            blackRectAnimator.start();
        }
    }

    function fadeIn() {
        if (blackRect.opacity == 1.0)
            return;
        blackRectAnimator.from = 0.0;
        blackRectAnimator.to = 1.0;
        blackRectAnimator.start();
    }

    function fadeOut() {
        if (blackRect.opacity == 0.0)
            return;
        // Use a timer to compensate for power on time
        blackRectTimer.start();
    }
}
