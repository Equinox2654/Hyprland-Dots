import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: wifiModule

    property string wifiIconConnected: "󰖩"
    property string wifiIconDisconnected: "󰖪"
    property bool wifiConnected: false
    property string icon: wifiIconDisconnected

    Text {
	id: wifiText
	text: wifiModule.icon
	anchors.centerIn: parent
	color: "#cdd6f4"
	font.pixelSize: 25
	font.family: "Meow Sans"
    }

    Process {
	id: wifiProcess
	command: ['sh', '-c', "nmcli -t -f type,state dev | grep '^wifi:connected'"]
	stdout: SplitParser {
	    onRead: data => {
		const status = data.trim() !== ""
		wifiModule.wifiConnected = status

		wifiModule.icon = status ? wifiModule.wifiIconConnected : wifiModule.wifiIconDisconnected
	    }
	}
    }

    Timer {
	interval: 1000
	running: true
	repeat: true
	onTriggered: {
	    wifiModule.wifiConnected = false
	    wifiProcess.running = true
	}
    }
}
