import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import "../javascript/WrapperCanvas.js" as Logic


PanelWindow {
    id: popupwindow
    visible: false

    property var module
    property var win

    color: "transparent"

    property var moduleX: module.x
    property var moduleY: module.y + module.rectHeight / 2 - 50

    property var isHovered: false

    anchors {
	left: true
	right: true
	bottom: true
	top: true
    }

    property real originalWidth: 400

    property real popupWidth: 0
    property real popupHeight: 300

    mask: Region {
	item: popupArea
    }

    function makeVisible() {
	visible = true
	popupWidth = originalWidth
    }

    function makeInvisible() {
	popupWidth = 0
    }
    
    function startTimer() {
	invisTimer.running = true
    }

    Behavior on popupWidth {
	NumberAnimation {
	    duration: 400
	    easing.type: Easing.InOutQuad
	}
    }

    onPopupWidthChanged: {
	if (popupWidth == 0) {
	    popupwindow.visible = false
	} else {
	    popupDraw.requestPaint()
	}
    }

    Canvas {
	id: popupDraw
	anchors.fill: parent

	onPaint: {
	    if (visible) {
		const ctx = getContext("2d")

		ctx.reset()
		
		Logic.drawMpris(ctx, 0, popupArea.y, popupWidth, popupArea.height)
	    }
	}
    }

    Rectangle {
	id: popupArea
	y: moduleY - popupHeight / 2
	width: popupWidth
	height: popupHeight
	clip: true
	color: "transparent"

	HoverHandler {
	    id: areaHover
	    onHoveredChanged: {
		if (hovered) {
		    popupwindow.isHovered = true
		    invisTimer.stop()
		} else {
		    popupwindow.isHovered = false
		    invisTimer.restart()
		}
	    }
	}

	Timer {
	    id: invisTimer
	    repeat: false
	    running: false
	    interval: 150
	    onTriggered: {
		if (!popupwindow.isHovered && !module.isMouse) {
		    makeInvisible()
		}
	    }
	}
    }
}
