import QtQuick
import QtQuick.Layouts

Rectangle {
    width: clockText.width + 15
    height: width - 7
    color: "#313244"
    radius: 30
    Text {
	id: clockText

	anchors.centerIn: parent

	text: Qt.formatDateTime(new Date(), "HH:mm")

	color: "#89b4fa"
	font.pixelSize: 12
	font.family: "Meow Sans"
	font.bold: true

	Timer {
	    interval: 60000
	    running: true
	    repeat: true
	    onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm")
	}
    }
}
