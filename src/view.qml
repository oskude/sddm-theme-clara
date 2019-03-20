import QtQuick 2.5

Item {
	anchors.fill: parent

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
			height: parent.height / 96

			NumberAnimation on width {
				id: dalineAnimOpen
				from: 0
				to: parent.width / 3
				duration: config.animation_duration
				onStopped: {
					username.forceActiveFocus()
				}
			}

			NumberAnimation on width {
				id: dalineAnimClose
				from: parent.width / 3
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
			font.pixelSize: parent.height / 20
			horizontalAlignment: TextInput.AlignHCenter
			width: parent.width
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottom: daline.top
			onAccepted: password.forceActiveFocus()
		}

		TextInput {
			id: password
			echoMode: TextInput.Password
			color: config.foreground_color
			font.pixelSize: parent.height / 20
			horizontalAlignment: TextInput.AlignHCenter
			width: parent.width
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: daline.bottom
			onAccepted: {
				this.focus = false
				dalineAnimClose.restart()
			}
		}
	}
}
