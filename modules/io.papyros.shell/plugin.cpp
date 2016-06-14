#include "plugin.h"

#include "desktop/desktopfile.h"
#include "desktop/desktopfiles.h"

#include "launcher/application.h"
#include "launcher/launchermodel.h"

void DesktopPlugin::registerTypes(const char *uri)
{
    // @uri Papyros.Desktop
    Q_ASSERT(uri == QStringLiteral("io.papyros.shell"));

    qmlRegisterType<DesktopFile>(uri, 0, 1, "DesktopFile");
    qmlRegisterSingletonType<DesktopFiles>(uri, 0, 1, "DesktopFiles", DesktopFiles::qmlSingleton);

    qmlRegisterUncreatableType<Application>(uri, 0, 1, "Application",
                                            "Applications are managed by the launcher model");
    qmlRegisterType<LauncherModel>(uri, 0, 1, "LauncherModel");
}
