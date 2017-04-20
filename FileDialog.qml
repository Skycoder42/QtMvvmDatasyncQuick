import QtQuick 2.8
import QtQuick.Controls 2.1
import Qt.labs.platform 1.0

FileDialog {
	id: fileDialog

	property bool isExport: false

	defaultSuffix: "dse"
	fileMode: isExport ? FileDialog.SaveFile : FileDialog.OpenFile
	folder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
	nameFilters: [qsTr("Datasync Export File (*.dse)"), qsTr("All Files (*)")]

	function getExportFile() {
		fileDialog.isExport = true;
		fileDialog.open();
	}

	function getImportFile() {
		fileDialog.isExport = false;
		fileDialog.open();
	}
}
