import Quickshell
import Quickshell.Services.UPower
import QtQuick
import "../javascript/Battery.js" as Logic

Rectangle {
    width: 45
    height: 35
    color: "#313244"
    radius: 30

    Text {
	id: battery
        anchors.centerIn: parent
        text: UPower.displayDevice ? Math.round(UPower.displayDevice.percentage * 100) + "%" : "N/A"
	color: {Logic.getColour()}
	font.pixelSize: 14
	font.family: "Meow Sans"
	font.bold: true
    }
}
