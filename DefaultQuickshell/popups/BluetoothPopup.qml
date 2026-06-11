import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import "../javascript/WrapperCanvas.js" as Logic


PanelWindow {
    id: popupwindow
    visible: false

    property var module
    property var  win
    property var bluetoothRoot

    color: "transparent"

    property var moduleX: bluetoothRoot.x + module.x
    property var moduleY: bluetoothRoot.y + module.y + module.rectHeight / 2 - 50

    property bool isHovered: false

    anchors {
	left: true
	right: true
	bottom: true
	top: true
    }

    property real originalWidth: 400

    property real popupWidth: 0
    property real popupHeight: 300

    mask: Region {
	item: popupArea
    }

    function makeVisible() {
	visible = true
	popupWidth = originalWidth
    }

    function makeInvisible() {
	popupWidth = 0
    }
    
    function startTimer() {
	invisTimer.running = true
    }

    Behavior on popupWidth {
	NumberAnimation {
	    duration: 400
	    easing.type: Easing.InOutQuad
	}
    }

    onPopupWidthChanged: {
	if (popupWidth == 0) {
	    popupwindow.visible = false
	} else {
	    popupDraw.requestPaint()
	}
    }

    Canvas {
	id: popupDraw
	anchors.fill: parent

	onPaint: {
	    if (visible) {
		const ctx = getContext("2d")

		ctx.reset()
		
		Logic.drawBluetooth(ctx, 0, popupArea.y, popupWidth, popupArea.height)
	    }
	}
    }

    Rectangle {
	id: popupArea
	y: moduleY - popupHeight / 2
	width: popupWidth
	height: popupHeight
	clip: true
	color: "transparent"

	HoverHandler {
	    id: areaHover
	    onHoveredChanged: {
		if (hovered) {
		    popupwindow.isHovered = true
		    invisTimer.stop()
		} else {
		    popupwindow.isHovered = false
		    invisTimer.restart()
		}
	    }
	}

	ColumnLayout {
	    id: info
	    spacing: 20
	    property bool enoughDevices: true
	    anchors.centerIn: parent

	    Item { height: 20 }

	    Repeater {
		model: {
		    const devices = Bluetooth.devices.values
		    const new_devices = devices.filter(function getConnected(val, index) {
			if (val.paired) return val
		    })
		    if (new_devices.length > 0) {
			info.enoughDevices = true
			return new_devices
		    }
		    info.enoughDevices = false
		    return []
		}
		Layout.alignment: Qt.alignBottom | Qt.alignHCenter
		anchors.centerIn: parent
		ColumnLayout {
		    property var device: Bluetooth.devices.values[index]
		    spacing: 10
		    Text {
			text: {
			    if (info.enoughDevices) {
				return device.deviceName
			    }
			    return "No Devices"
			}
			Layout.alignment: Qt.alignHCenter
			color: "#cdd7f4"
			font.family: "Meow Sans"
			font.pixelSize: 16
		    }

		    Rectangle {
			id: connectButton
			width: connectText.width + 25
			height: connectText.height + 15
			radius: 30
			color: connectHover.hovered ? "#585b70" : "#313244"
			Layout.alignment: Qt.alignBottom | Qt.alignHCenter
			Text {
			    id: connectText
			    text: device.connected ? "Disconnect" : "Connect"
			    color: "#cdd7f4"
			    font.family: "Meow Sans"
			    font.pixelSize: 16
			    anchors.centerIn: parent
			}

			TapHandler {
			    id: connectClick
			    onTapped: device.connected ? device.disconnect() : device.connect()
			}

			HoverHandler {
			    id: connectHover
			    onHoveredChanged: {
				if (hovered) {
				    popupwindow.isHovered = true
				    invisTimer.stop()
				}
			    }
			}
		    }

		}
	    }
	}

	Timer {
	    id: invisTimer
	    repeat: false
	    running: false
	    interval: 150
	    onTriggered: {
		if (!popupwindow.isHovered && !module.isMouse) {
		    makeInvisible()
		}
	    }
	}
    }
}
