import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: connections

    property var bluetoothPopup
    property alias bluetoothWidget: bluetooth

    width: 40
    height: 120
    radius: 30

    color: "#313244"

    ColumnLayout {
	height: 80
	anchors.centerIn: parent
	spacing: 10

	Audio {
	    Layout.alignment: Qt.alignTop | Qt.alignHCenter
	}

	Wifi {
	    Layout.alignment: Qt.alignVCenter | Qt.alignHCenter
	}

	Bluetooth {
	    id: bluetooth
	    Layout.alignment: Qt.alignBottom | Qt.alignHCenter
	    popup: bluetoothPopup
	    connections: connections
	}
    }
}
