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
			dalineAnimOpen.restart()
		}
		onLoginSucceeded: {
			// no time to do anything interesting...
		}
	}

	Rectangle {
		color: config.background_color
		anchors.fill: parent
		Rectangle {
			id: daline
			color: config.foreground_color
			anchors.centerIn: parent
			height: root.height / 96
			NumberAnimation on width {
				id: dalineAnimOpen
				from: 0
				to: root.width / 3
				duration: config.animation_duration
				onStopped: {
					username.forceActiveFocus()
				}
			}
			NumberAnimation on width {
				id: dalineAnimClose
				from: root.width / 3
				to: 0
				duration: config.animation_duration
				running: false
				onStopped: {
					sddm.login(username.text, password.text, 0)
				}
			}
		}
		TextInput {
			id: username
			color: config.foreground_color
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
			color: config.foreground_color
			font.pixelSize: root.height / 20
			horizontalAlignment: TextInput.AlignHCenter
			width: root.width
			anchors.horizontalCenter: root.horizontalCenter
			anchors.top: daline.bottom
			onAccepted: {
				this.focus = false
				dalineAnimClose.restart()
			}
		}
	}
}
