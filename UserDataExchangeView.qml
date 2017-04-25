import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import de.skycoder42.quickextras 2.0
import de.skycoder42.qtmvvm.quick 1.0
import de.skycoder42.qtmvvm.datasync.quick 1.0

Page {
	id: exchangeView
	property UserDataExchangeControl control: null

	header: ActionBar {
		id: toolbar
		title: qsTr("User data exchange")
		showMenuAsBack: true
		onMenuButtonClicked: control.close()
	}

	PresenterProgress {}

	Pane {
		anchors.fill: parent

		GridLayout {
			anchors.fill: parent
			columns: 3
			columnSpacing: 14

			Label {
				text: qsTr("Port:")
			}

			SpinBox {
				id: portBox
				Layout.fillWidth: true
				editable: true
				from: 0
				to: 65535
				value: control ? control.port : 0

				textFromValue: function(value) {
					return value;
				}
			}

			AppBarButton {
				text: qsTr("Apply Port change")
				imageSource: "image://svg/de/skycoder42/qtmvvm/datasync/quick/icons/ic_check"
				onClicked: control.port = portBox.value
				size: portBox.height
			}

			Label {
				text: qsTr("Device Name:")
			}

			TextField {
				id: nameEdit
				Layout.columnSpan: 2
				Layout.fillWidth: true
				text: control ? control.deviceName : ""
				selectByMouse: true
				placeholderText: qsTr("Name to display this device as")
				onEditingFinished: control.deviceName = nameEdit.text
			}

			ListView {
				Layout.columnSpan: 3
				Layout.fillHeight: true
				Layout.fillWidth: true
				clip: true

				model: control ? control.model : null

				delegate: ItemDelegate {
					width: parent.width

					contentItem: ColumnLayout {
						Label {
							id: nameLabel
							text: name
						}
						Label {
							id: addressLabel
							text: address
							font.pointSize: nameLabel.font.pointSize - 2
							opacity: 0.75
							leftPadding: 12
						}
					}

					onClicked: control.exportTo(index)
				}
			}
		}
	}
}
