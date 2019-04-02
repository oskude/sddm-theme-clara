import QtQuick 2.5
import org.kde.plasma.core 2.0 as PlasmaCore

PlasmaCore.ColorScope {
	width: 640
	height: 480

	Loader {
		property int maxSize: 42
		anchors.fill: parent
		onWidthChanged: {
			this.maxSize = this.width < this.height ? this.width : this.height
			this.source = ""; // TODO: do we really need this to force reload?
			this.source = "view.qml"
		}
	}
}
