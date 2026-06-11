import Quickshell
import QtQuick
import "../javascript/WrapperCanvas.js" as Logic

Scope {
    id: root
    Variants {
	model: Quickshell.screens
	PanelWindow {
	    anchors {
		top: true
		bottom: true
		left: true
		right: true
	    }

	    exclusiveZone: -1
	    color: "transparent"

	    mask: Region {}

	    Canvas {
		id: barCanvas
		anchors.fill: parent

		onPaint: {
		    Logic.draw(getContext("2d"), width, height)
		}
	    }
	}
    }
}
