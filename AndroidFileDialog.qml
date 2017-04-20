import QtQuick 2.8
import de.skycoder42.androidutils 1.0

QtObject {
	id: fileDialog

	property url file: ""
	property bool isExport: false
	signal accepted()

	function getExportFile() {
		accepted();
	}

	function getImportFile() {
		accepted();
	}
}
