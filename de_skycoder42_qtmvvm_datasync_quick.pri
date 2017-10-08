QT *= network jsonserializer datasync

HEADERS += \
    $$PWD/filehelper.h

SOURCES += \
    $$PWD/register.cpp \
    $$PWD/filehelper.cpp

RESOURCES += \
	$$PWD/de_skycoder42_qtmvvm_datasync_quick.qrc

TRANSLATIONS += $$PWD/qtmvvm_datasync_quick_de.ts \
	$$PWD/qtmvvm_datasync_quick_template.ts

INCLUDEPATH += $$PWD
