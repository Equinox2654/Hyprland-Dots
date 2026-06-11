import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth
import QtQuick

Item {
    id: bluetoothModule

    property string iconConnected: ""
    property string iconDisconnected: "󰂲"

    property var connections

    property var popup

    property var rectHeight: text.height

    property alias buttonArea: button
    property bool isMouse: false

    Text {
	id: text
	text: (Bluetooth.devices.values.length > 0 && Bluetooth.devices.values[0].connected)
      ? iconConnected : iconDisconnected
	anchors.centerIn: parent
	color: "#cdd6f4"
	font.pixelSize: 25
	font.family: "Meow Sans"
    }

    MouseArea {
	id: button
	anchors.fill: text
	hoverEnabled: true
	onEntered: {
	    popup.makeVisible()
	    isMouse = true
	}
	onExited: {
	    popup.startTimer()
	    isMouse = false
	}
    }
}
