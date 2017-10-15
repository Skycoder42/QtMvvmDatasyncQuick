import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import de.skycoder42.quickextras 2.0
import de.skycoder42.qtmvvm.quick 1.0
import de.skycoder42.qtmvvm.datasync.quick 1.0

AlertDialog {
	id: changeDialog
	title: qsTr("Change remote")
	property ChangeRemoteControl control: null

	GridLayout {
		width: parent.width
		columns: 2

		Label {
			text: qsTr("Url:")
		}

		TextField {
			id: urlField
			Layout.fillWidth: true
			focus: true
			selectByMouse: true

			text: control ? control.url : ""
			placeholderText: qsTr("wss://example.com/app/")
			validator: UrlValidator {
				allowedSchemes: ["wss", "ws"]
			}

			onTextEdited: {
				if(acceptableInput && control)
					control.url = text;
			}
		}

		CheckBox {
			id: secretBox
			text: qsTr("Secret:")

			QtMvvmBinding {
				control: changeDialog.control
				controlProperty: "changeSecret"
				view: secretBox
				viewProperty: "checked"
			}
		}

		TextField {
			id: secretField
			Layout.fillWidth: true
			enabled: secretBox.checked
			echoMode: TextInput.Password
			placeholderText: qsTr("Uncheck box to keep current")

			QtMvvmBinding {
				control: changeDialog.control
				controlProperty: "serverSecret"
				view: secretField
				viewProperty: "text"
			}
		}

		Label {
			text: qsTr("Clear Data:")
		}

		Switch {
			id: resetSwitch
			checked: true

			QtMvvmBinding {
				control: changeDialog.control
				controlProperty: "resetData"
				view: resetSwitch
				viewProperty: "checked"
			}
		}
	}

	footer: DialogButtonBox {
		id: btnBox
		standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel | DialogButtonBox.RestoreDefaults

		Component.onCompleted: {
			var btn = standardButton(DialogButtonBox.Ok);
			btn.enabled = Qt.binding(function() { return control && urlField.acceptableInput; });

			var rBtn = standardButton(DialogButtonBox.RestoreDefaults);
			rBtn.clicked.connect(function() {
				control.reset();
				changeDialog.close();
			});
		}
	}

	onAccepted: {
		control.accept();
	}
}
