import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import de.skycoder42.quickextras 2.0
import de.skycoder42.androidutils 1.1
import de.skycoder42.qtmvvm.quick 1.0
import de.skycoder42.qtmvvm.datasync.quick 1.0
import Qt.labs.platform 1.0 as Labs

Page {
	id: mainView
	property DatasyncControl control: null

	header: ActionBar {
		id: toolbar
		title: qsTr("Datasync Status")
		showMenuAsBack: true
		onMenuButtonClicked: control.close()

		CommonStyle {
			id: styleHelper
		}

		AppBarButton {
			id: exchangeButton
			imageSource: "image://svg/de/skycoder42/qtmvvm/datasync/quick/icons/ic_import_export"
			text: qsTr("Exchange user data")

			onClicked: control.initExchange()
		}

		moreMenu: Menu {
			MenuItem {
				text: qsTr("Export to file")
				onClicked: fileDialog.getExportFile()
			}
			MenuItem {
				text: qsTr("Import from file")
				onClicked: fileDialog.getImportFile()
			}
			MenuItem {
				text: qsTr("Resync")
				onClicked: control.resync()
			}
		}
	}

	PresenterProgress {}

	Pane {
		anchors.fill: parent

		ColumnLayout {
			anchors.left: parent.left
			anchors.right: parent.right
			anchors.top: parent.top
			spacing: 14

			Switch {
				id: enableSwitch
				text: qsTr("Synchronization enabled")
				Layout.fillWidth: true

				checked: control ? control.syncEnabled : false
				onCheckedChanged: control.syncEnabled = enableSwitch.checked
			}

			Label {
				id: statusLabel
				Layout.fillWidth: true
				text: control ? control.statusString : ""
				font.bold: true
				font.pointSize: 16
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
			}

			ProgressBar {
				id: syncProgress
				Layout.fillWidth: true
				from: 0
				to: 1
				value: control ? control.syncProgress : 0
				visible: control ? control.showProgress : false
			}
		}

		FloatingActionButton {
			anchors.right: parent.right
			anchors.bottom: parent.bottom

			Material.foreground: styleHelper.foreground

			imageSource: "image://svg/de/skycoder42/qtmvvm/datasync/quick/icons/ic_sync"
			text: qsTr("Synchronize")

			onClicked: control.sync()
		}
	}

	FileDialog {
		id: fileDialog

		property bool isExport: false

		defaultSuffix: "dse"
		mimeType: "text/dse"
		fileMode: isExport ? Labs.FileDialog.SaveFile : Labs.FileDialog.OpenFile
		folder: Labs.StandardPaths.writableLocation(Labs.StandardPaths.HomeLocation)
		nameFilters: [qsTr("Datasync Export File (*.dse)"), qsTr("All Files (*)")]

		function getExportFile() {
			fileDialog.isExport = true;
			fileDialog.open();
		}

		function getImportFile() {
			fileDialog.isExport = false;
			fileDialog.open();
		}

		onAccepted: {
			if(isExport)
				control.exportUserData(file)
			else
				control.importUserData(file)
		}
	}
}
