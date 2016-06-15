import QtQuick 2.0

Item {
    signal wake()
    signal idle()
    signal keyPressed(var event)
    signal keyReleased(var event)

    property var insets: {
        'left': 0,
        'right': 0,
        'top': 0,
        'bottom': 0
    }

    readonly property var windows: {
        var windows = [];

        for (var i = 0; i < windowsModel.count; i++) {
            var window = windowsModel.get(i).window;

            if (window.designedOutput === output)
                windows.push(window);
        }

        return windows;
    }

    onInsetsChanged: updateGeometry()

    function updateGeometry() {
        output.availableGeometry = Qt.rect(
                output.geometry.x + insets.left,
                output.geometry.y + insets.top,
                output.geometry.width - insets.left - insets.right,
                output.geometry.height - insets.top - insets.bottom)
        console.log(output.availableGeometry, output.geometry)
    }
}
