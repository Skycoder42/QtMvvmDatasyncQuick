#ifndef FILEHELPER_H
#define FILEHELPER_H

#include <QObject>
#include <QUrl>
#include <datasynccontrol.h>

class FileHelper : public QObject
{
	Q_OBJECT

	Q_PROPERTY(DatasyncControl* control MEMBER _control NOTIFY controlChanged)

public:
	explicit FileHelper(QObject *parent = nullptr);

public slots:
	void triggerExport(const QUrl &url);
	void triggerImport(const QUrl &url);

signals:
	void controlChanged(DatasyncControl* control);

private:
	DatasyncControl* _control;
};

#endif // FILEHELPER_H
