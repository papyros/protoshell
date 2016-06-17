project(io.papyros.Shell)

cmake_minimum_required(VERSION 3.0.0)

set(CMAKE_AUTORCC ON)

# Set version
set(PROJECT_VERSION "0.1.0")
set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_SOVERSION 0)

# Options
option(DEVELOPMENT_BUILD "Enable options for developers" OFF)
option(ENABLE_ALSA "Enables Alsa mixer backend" ON)
option(ENABLE_PULSEAUDIO "Enables PulseAudio mixer backend" ON)

# ECM setup
find_package(ECM 1.4.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} "${CMAKE_SOURCE_DIR}/cmake")

# Macros
include(FeatureSummary)
include(KDEInstallDirs)
include(KDECompilerSettings)
include(KDECMakeSettings)
include(CheckIncludeFile)
include(CheckSymbolExists)

# Build flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden -Werror -Wall -Wextra -Wformat -Wswitch-default -Wunused-parameter -pedantic -std=c++11")

add_definitions(-DQT_USE_FAST_CONCATENATION -DQT_USE_FAST_OPERATOR_PLUS)
remove_definitions(-DQT_NO_CAST_FROM_ASCII -DQT_STRICT_ITERATORS -DQT_NO_CAST_FROM_BYTEARRAY)

# Minimum version requirements
set(QT_MIN_VERSION "5.6.0")
set(KF5_MIN_VERSION "5.8.0")

find_package(PAM REQUIRED)
find_package(GreenIsland 0.7.90 REQUIRED COMPONENTS Server)

# Find Qt5
find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
             Core
             DBus
             Xml
             Gui
             Widgets
             Qml
             Quick
             WaylandClient)

# Find KF5
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS
             Solid Declarative NetworkManagerQt)

find_package(QT5XDG REQUIRED)
find_package(Papyros REQUIRED)

# Check for prctl
check_include_file("sys/prctl.h" HAVE_SYS_PRCTL_H)
check_symbol_exists(PR_SET_DUMPABLE "sys/prctl.h" HAVE_PR_SET_DUMPABLE)
add_feature_info("prctl-dumpable" HAVE_PR_SET_DUMPABLE "Required to prevent ptrace on the compositor process")

# Hack because QtWayland doesn't set this at all
set(Qt5WaylandClient_PRIVATE_INCLUDE_DIRS
        "${_qt5WaylandClient_install_prefix}/include/qt/QtWaylandClient/${Qt5WaylandClient_VERSION}"
        "${_qt5WaylandClient_install_prefix}/include/qt/QtWaylandClient/${Qt5WaylandClient_VERSION}/QtWaylandClient"
    )

add_subdirectory(3rdparty)
add_subdirectory(compositor)
add_subdirectory(decorations)
add_subdirectory(headers)
add_subdirectory(modules)

if(DEVELOPMENT_BUILD)
    greenisland_install_shell(io.papyros.shell shell)
endif()

# Display featute summary
feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
