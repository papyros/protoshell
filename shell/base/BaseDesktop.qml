import QtQuick 2.0

Item {
    signal wake()
    signal idle()
    signal keyPressed(var event)
    signal keyReleased(var event)
}
