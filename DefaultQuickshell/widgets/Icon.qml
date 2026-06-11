import Quickshell
import QtQuick

Rectangle {

    color: "transparent"
    radius: 30
    height: text.height
    width: text.width

    Text {
	id: text
	anchors.centerIn: parent
	text: "󰣇"
	color: "#cdd6f4"
	font.family: "Meow Sans"
	font.pixelSize: 40
    }
}
