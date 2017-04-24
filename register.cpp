#include <QCoreApplication>
#include <QQmlEngine>
#include <datasynccontrol.h>
#include <userdataexchangecontrol.h>
#include "filehelper.h"

static void registerDatasyncTypes()
{
	qmlRegisterUncreatableType<DatasyncControl>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "DatasyncControl", "Controls cannot be created!");
	qmlRegisterUncreatableType<UserDataExchangeControl>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "UserDataExchangeControl", "Controls cannot be created!");
	qmlRegisterType<FileHelper>("de.skycoder42.qtmvvm.datasync.quick", 1, 0, "FileHelper");
}

Q_COREAPP_STARTUP_FUNCTION(registerDatasyncTypes)
