import QtQuick 2.5
import org.kde.plasma.core 2.0 as PlasmaCore

PlasmaCore.ColorScope {
	id: root
	width: 640
	height: 480

	Connections {
		target: sddm
		onLoginFailed: {
			username.clear()
			password.clear()
			openDalineAnim.restart()
		}
		onLoginSucceeded: {
			// no time to do anything interesting...
		}
	}

	Rectangle {
		color: config.background
		anchors.fill: parent
		Rectangle {
			id: daline
			color: config.foreground
			anchors.centerIn: parent
			height: root.height / 96
			NumberAnimation on width {
				id: openDalineAnim
				from: 0
				to: root.width / 3
				duration: 400
				onStopped: {
					username.forceActiveFocus()
				}
			}
			NumberAnimation on width {
				id: closeDalineAnim
				from: root.width / 3
				to: 0
				duration: 400
				running: false
				onStopped: {
					sddm.login(username.text, password.text, 0)
				}
			}
		}
		TextInput {
			id: username
			color: config.foreground
			font.pixelSize: root.height / 20
			horizontalAlignment: TextInput.AlignHCenter
			width: root.width
			anchors.horizontalCenter: root.horizontalCenter
			anchors.bottom: daline.top
			onAccepted: password.forceActiveFocus()
		}
		TextInput {
			id: password
			echoMode: TextInput.Password
			color: config.foreground
			font.pixelSize: root.height / 20
			horizontalAlignment: TextInput.AlignHCenter
			width: root.width
			anchors.horizontalCenter: root.horizontalCenter
			anchors.top: daline.bottom
			onAccepted: {
				this.focus = false
				closeDalineAnim.restart()
			}
		}
	}
}
