file(GLOB_RECURSE SOURCES *.cpp *.h)

configure_file(qml/ShellSettings.qml.in ShellSettings.qml)

add_library(papyrosdesktop SHARED ${SOURCES})
target_link_libraries(papyrosdesktop
                      Qt5::Core
                      Qt5::Qml
                      Qt5::DBus
                      Qt5::Quick
                      GreenIsland::Server
                      Qt5Xdg
                      Papyros::Core)

install(FILES qmldir ${CMAKE_CURRENT_BINARY_DIR}/ShellSettings.qml
    DESTINATION ${QML_INSTALL_DIR}/io/papyros/shell)
install(TARGETS papyrosdesktop
    DESTINATION ${QML_INSTALL_DIR}/io/papyros/shell)
