cmake_minimum_required(VERSION 3.10)

project(imgui
        VERSION 1.0
        LANGUAGES CXX)

# ------------------------------------------------------------------------------------------------------------------------------------
# options
# ----------
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif ()

# ------------------------------------------------------------------------------------------------------------------------------------
# dependencies (third party)
# ----------
include(../../cmake-helpers/DepOpenGL.cmake)
include(../../cmake-helpers/ConfigureCompileOptions.cmake)
include(../glfw/bk.cmake)
include(../SDL2/bk.cmake)

# ------------------------------------------------------------------------------------------------------------------------------------
# source
# ----------
set(IMGUI_SRC_SHARED
        imgui.cpp
        imgui_demo.cpp
        imgui_draw.cpp
        imgui_tables.cpp
        imgui_widgets.cpp
        )

add_library(imgui_opengl3_sdl2 STATIC
        ${IMGUI_SRC_SHARED}
        backends/imgui_impl_opengl3.cpp
        backends/imgui_impl_sdl.cpp
        )
ConfigureCompileOptions(imgui_opengl3_sdl2 PUBLIC)
target_include_directories(imgui_opengl3_sdl2 PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>)
link_opengl(imgui_opengl3_sdl2 PUBLIC)
link_sdl2(imgui_opengl3_sdl2 PUBLIC)

add_library(imgui_opengl3_glfw STATIC
        ${IMGUI_SRC_SHARED}
        backends/imgui_impl_opengl3.cpp
        backends/imgui_impl_glfw.cpp
        )
ConfigureCompileOptions(imgui_opengl3_glfw PUBLIC)
target_include_directories(imgui_opengl3_glfw PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>)
link_glfw(imgui_opengl3_glfw PUBLIC)
link_opengl(imgui_opengl3_glfw PUBLIC)

unset(IMGUI_SRC_SHARED)

# ------------------------------------------------------------------------------------------------------------------------------------
# run emscripten build
# ----------
add_custom_command(TARGET imgui_opengl3_sdl2 POST_BUILD COMMAND ${PROJECT_SOURCE_DIR}/emscripten-compile-imgui-opengl3-sdl2.sh WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

# ------------------------------------------------------------------------------------------------------------------------------------
# install
# ----------
install(FILES
        "${PROJECT_SOURCE_DIR}/imconfig.h"
        "${PROJECT_SOURCE_DIR}/imgui.h"
        "${PROJECT_SOURCE_DIR}/imgui_internal.h"
        "${PROJECT_SOURCE_DIR}/imstb_rectpack.h"
        "${PROJECT_SOURCE_DIR}/imstb_textedit.h"
        "${PROJECT_SOURCE_DIR}/imstb_truetype.h"
        PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include
        )
        
install(FILES
        "${PROJECT_SOURCE_DIR}/backends/imgui_impl_glfw.h"
        "${PROJECT_SOURCE_DIR}/backends/imgui_impl_opengl3.h"
        "${PROJECT_SOURCE_DIR}/backends/imgui_impl_sdl.h"
        PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include/backends
        )

install(FILES
        "$<TARGET_FILE_DIR:imgui_opengl3_sdl2>/libimgui_opengl3_sdl2.a"
        "$<TARGET_FILE_DIR:imgui_opengl3_glfw>/libimgui_opengl3_glfw.a"
        "${PROJECT_SOURCE_DIR}/libimgui_opengl3_sdl2.bc"
        PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        )

install(FILES
        "${PROJECT_SOURCE_DIR}/misc/fonts/Cousine-Regular.ttf"
        "${PROJECT_SOURCE_DIR}/misc/fonts/DroidSans.ttf"
        "${PROJECT_SOURCE_DIR}/misc/fonts/Karla-Regular.ttf"
        "${PROJECT_SOURCE_DIR}/misc/fonts/ProggyClean.ttf"
        "${PROJECT_SOURCE_DIR}/misc/fonts/ProggyTiny.ttf"
        "${PROJECT_SOURCE_DIR}/misc/fonts/Roboto-Medium.ttf"
        PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
        DESTINATION ${CMAKE_INSTALL_PREFIX}/fonts
        )

