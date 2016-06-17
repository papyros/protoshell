configure_file(papyros.desktop.in ${CMAKE_CURRENT_BINARY_DIR}/papyros.desktop)
configure_file(papyros-session.in ${CMAKE_CURRENT_BINARY_DIR}/papyros-session @ONLY)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/papyros.desktop
    DESTINATION ${CMAKE_INSTALL_DATADIR}/wayland-sessions)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/papyros-session
    DESTINATION ${BIN_INSTALL_DIR})
