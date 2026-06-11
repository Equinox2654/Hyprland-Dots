import Quickshell
import QtQuick

Scope {
    id: root
    Variants {
	model: Quickshell.screens

	PanelWindow {
	    required property var modelData
	    screen: modelData

	    height: 10

	    color: "transparent"

	    anchors {
		top: true
		left: true
		right: true
	    }

	    exclusiveZone: 10
	}
    }
}
