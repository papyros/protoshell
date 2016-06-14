/****************************************************************************
 * This file is part of Hawaii.
 *
 * Copyright (C) 2014-2016 Pier Luigi Fiorini
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

import QtQuick 2.5
import QtQuick.Window 2.2
import GreenIsland 1.0 as GreenIsland

GreenIsland.ExtendedOutput {
    id: output

    property alias idleDimmerComponent: outputWindow.idleDimmerComponent
    property alias desktopComponent: outputWindow.desktopComponent

    readonly property bool primary: compositor.primaryScreen === nativeScreen
    readonly property Item surfacesArea: desktop.hasOwnProperty("surfacesArea")
            ? desktop.surfacesArea : null

    property alias desktop: outputWindow.desktop
    property alias idleDimmer: outputWindow.idleDimmer

    property QtObject activeWindow: null
    property int idleInhibit: 0

    manufacturer: nativeScreen.manufacturer
    model: nativeScreen.model
    position: nativeScreen.position
    currentModeId: nativeScreen.currentMode
    physicalSize: nativeScreen.physicalSize
    subpixel: nativeScreen.subpixel
    transform: nativeScreen.transform
    scaleFactor: nativeScreen.scaleFactor
    sizeFollowsWindow: false
    automaticFrameCallback: powerState === GreenIsland.ExtendedOutput.PowerStateOn

    window: OutputWindow {
        id: outputWindow

        output: output
    }

    onGeometryChanged: desktop.updateGeometry()

    /*
     * Methods
     */

    function wake() {
        if (idleDimmer)
            idleDimmer.fadeOut();
        output.powerState = GreenIsland.ExtendedOutput.PowerStateOn;
    }

    function idle() {
        if (idleDimmer)
            idleDimmer.fadeIn();
    }
}
