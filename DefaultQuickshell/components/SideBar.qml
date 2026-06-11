import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../widgets/"
import "../popups/" as Popups

Scope {
    id: root

    Variants {
	model: Quickshell.screens

	PanelWindow {
	    id: window
	    required property var modelData
	    screen: modelData

	    color: "transparent"

	    anchors {
		top: true
		bottom: true
		left: true
	    }

	    exclusiveZone: 60

	    ColumnLayout {
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		width: 60
		spacing: 10

		Icon {
		    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
		}

		Item {}

		Workspaces {
		    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
		}

		Item {}

		Mpris {
		    id: mprisWidget
		    Layout.fillWidth: true
		    Layout.fillHeight: true
		    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
		    popup: mprisPopup
		}

		SystemConnections {
		    id: sysConnections
		    Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
		    bluetoothPopup: bluetoothPopup
		}

		Item { height: 5 }

		BatteryWidget {
		    Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
		}

		ClockWidget {
		    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
		}

		Item { height: 5 }

	    }

	    Popups.BluetoothPopup {
		id: bluetoothPopup
		win: window
		module: sysConnections.bluetoothWidget
		bluetoothRoot: sysConnections
	    }

	    Popups.MprisPopup {
		id: mprisPopup
		win: window
		module: mprisWidget
	    }

	}
    }
}
