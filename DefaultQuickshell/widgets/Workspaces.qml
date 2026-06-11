import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
    width: column.width + 15
    height: column.height + 15
    radius: 30

    color: "#313244"

    ColumnLayout {
	id: column
	anchors.centerIn: parent
	spacing: 9
	Repeater {
	    model: 10

	    Rectangle {
		Layout.preferredWidth: 35
		Layout.preferredHeight: isActive ? 70 : 35
		Layout.alignment: Qt.alignCenter
		color: isActive ? "#cba6f7" : "#11111b"
		radius: 30

		Behavior on Layout.preferredHeight {
		    NumberAnimation {
			duration: 400
			easing.type: Easing.InOutQuad
		    }
		}

		property var workspace: {
		    Hyprland.workspaces.values
		    for (var i= 0; i < Hyprland.workspaces.values.length; i++) {
			var ws = Hyprland.workspaces.values[i];
			if (ws.id === (index + 1)) {
			    return ws;
			}
		    }
		    return null
		}

		property bool isActive: workspace !== null && Hyprland.focusedWorkspace.id === (index + 1)
		property bool hasWindows: workspace !== null

		Text {
		    anchors.centerIn: parent
		    visible: isActive
		    text: ""
		    font.pixelSize: 24
		    color: "#11111b"
		    font.family: "Meow Sans"
		}
	    }
	}
    }
}
