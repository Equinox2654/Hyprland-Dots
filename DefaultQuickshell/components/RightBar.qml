import Quickshell
import QtQuick

Scope {
    id: root
    Variants {
	model: Quickshell.screens

	PanelWindow {
	    required property var modelData
	    screen: modelData

	    width: 10

	    color: "transparent"

	    anchors {
		top: true
		bottom: true
		right: true
	    }

	    exclusiveZone: 10
	}
    }
}
