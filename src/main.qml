import QtQuick 2.5
import org.kde.plasma.core 2.0 as PlasmaCore

PlasmaCore.ColorScope {
	width: 640
	height: 480

	Loader {
		anchors.fill: parent
		onWidthChanged: {
			this.source = ""; // TODO: do we really need this to force reload?
			this.source = "view.qml"
		}
	}
}
