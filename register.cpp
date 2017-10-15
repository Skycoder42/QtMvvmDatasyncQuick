#include <QCoreApplication>
#include <QQmlEngine>
#include <datasynccontrol.h>
#include <userdataexchangecontrol.h>
#include <changeremotecontrol.h>
#include <qurlvalidator.h>
#include "filehelper.h"

static void registerDatasyncTypes()
{
	qmlRegisterUncreatableType<DatasyncControl>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "DatasyncControl", QStringLiteral("Controls cannot be created!"));
	qmlRegisterUncreatableType<UserDataExchangeControl>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "UserDataExchangeControl", QStringLiteral("Controls cannot be created!"));
	qmlRegisterUncreatableType<ChangeRemoteControl>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "ChangeRemoteControl", QStringLiteral("Controls cannot be created!"));
	qmlRegisterType<FileHelper>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "FileHelper");

	qmlRegisterType<QUrlValidator>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "UrlValidator");
}

Q_COREAPP_STARTUP_FUNCTION(registerDatasyncTypes)
