import QtQuick 2.0

Item {
    id: pagedGrid

    property var model

    property int rows
    property int columns

    property Component delegate

    readonly property var count: model.rowCount()

    readonly property int pageCount: rows * columns
    readonly property alias pages: pageView.count
    property alias currentPage: pageView.currentIndex

    // Scroll through pages using the mouse weel
    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true

        onWheel: {
            if (wheel.angleDelta.y > 0)
                pageView.decrementCurrentIndex();
            else
                pageView.incrementCurrentIndex();
        }
    }

    ListView {
        id: pageView

        anchors.fill: parent

        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 500
        currentIndex: 0

        model: Math.ceil(pagedGrid.count/pageCount)

        delegate: Grid {
            id: page

            readonly property int pageIndex: index

            width: pagedGrid.width
            height: pagedGrid.height

            columns: pagedGrid.columns

            Repeater {
                model: pageIndex == pageView.count - 1
                        ? pagedGrid.count % pagedGrid.pageCount
                        : pagedGrid.pageCount

                delegate: Loader {
                    width: pagedGrid.width/pagedGrid.rows
                    height: pagedGrid.height/pagedGrid.columns

                    sourceComponent: pagedGrid.delegate

                    readonly property int pageIndex: page.pageIndex

                    readonly property var model: pagedGrid.model.get(index + pageIndex * pagedGrid.pageCount)
                }
            }
        }
    }
}
