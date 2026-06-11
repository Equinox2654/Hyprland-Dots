import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: mprisModule

    color: "transparent"

    property var popup

    property var rectHeight: mprisModule.height

    property alias hoverHandler: hoverHandler
    property bool isMouse: false

    implicitWidth: text.height + 15
    implicitHeight: text.width + 20

    property var player: Mpris.players.values[0] ? Mpris.players.values[0] : null

    Rectangle {
	id: rect1
	anchors.centerIn: parent
	width: text.height + 15
	height: text.width + 20
	color: "#313244"
	radius: 30
	Text {
	    anchors.centerIn: parent
	    id: text
	    text: player ? `${player.isPlaying ? "" : ""} ${player.trackTitle} - ${player.trackArtist}`.slice(0, 30) : "Nothing"
	    rotation: -90
	    color: "#cdd6f4"
	    font.pixelSize: 18
	    font.family: "Meow Sans"
	}

	HoverHandler {
	    id: hoverHandler
	    onHoveredChanged: {
		if (hovered)
		{
		    isMouse = true
		    popup.makeVisible()
		}
		else
		{
		    isMouse = false
		    popup.makeInvisible()
		}
	    }
	}

	TapHandler {
	    id: tapHandler
	    onTapped: player.isPlaying ? player.pause() : player.play()
	}
    }
}
