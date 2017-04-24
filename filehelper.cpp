#include "filehelper.h"
#include <coremessage.h>
#ifdef Q_OS_ANDROID
#include <contentdevice.h>
#else
#include <QFile>
#endif

FileHelper::FileHelper(QObject *parent) :
	QObject(parent),
	_control(nullptr)
{}

void FileHelper::triggerExport(const QUrl &url)
{
	if(!url.isValid())
		return;
#ifdef Q_OS_ANDROID
	auto device = new ContentDevice(url);
#else
	auto device = new QFile(url.toLocalFile());
#endif
	if(device->open(QIODevice::WriteOnly))
		_control->exportUserData(device);
	else {
		CoreMessage::critical(tr("User data export"), tr("Failed to create file with error: %1").arg(device->errorString()));
		delete device;
	}
}

void FileHelper::triggerImport(const QUrl &url)
{
	if(!url.isValid())
		return;
#ifdef Q_OS_ANDROID
	auto device = new ContentDevice(url);
#else
	auto device = new QFile(url.toLocalFile());
#endif
	if(device->open(QIODevice::ReadOnly))
		_control->importUserData(device);
	else {
		CoreMessage::critical(tr("User data import"), tr("Failed to read file with error: %1").arg(device->errorString()));
		delete device;
	}
}
