QT *= network jsonserializer datasync

RESOURCES += \
	$$PWD/de_skycoder42_qtmvvm_datasync_quick.qrc

INCLUDEPATH += $$PWD

SOURCES += \
    $$PWD/register.cpp \
    $$PWD/filehelper.cpp

HEADERS += \
    $$PWD/filehelper.h
