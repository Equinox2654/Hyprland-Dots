import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
    id: audioModule
    property int volume: 0
    property bool muted: false

    property string iconMuted: ""
    property string iconLow: ""
    property string iconHigh: ""

    function getIcon() {
	if (muted || volume == 0) return iconMuted;
	if (volume < 40) return iconLow;
	return iconHigh
    }

    Text {
	id: text
	text: getIcon()
	anchors.centerIn: parent
	color: "#cdd6f4"
	font.pixelSize: 20
	font.family: "Meow Sans"
    }

    Process {
	id: volumeProcess
	command: ['pamixer', '--get-volume']
	stdout: SplitParser {
	    onRead: data => {
		audioModule.volume = parseInt(data.trim())
	    }
	}
    }

    Process {
	id: muteProcess
	command: ['pamixer', '--get-mute']
	stdout: SplitParser {
	    onRead: data => {
		audioModule.muted = data.trim() === "true"
	    }
	}
    }

    Timer {
	interval: 200
	running: true
	repeat: true
	onTriggered: {
	    volumeProcess.running = true
	    muteProcess.running = true
	}
    }
}
