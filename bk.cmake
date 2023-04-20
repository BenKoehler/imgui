set(BK_IMGUI_VERSION "1.89.1")

include(${PROJECT_SOURCE_DIR}/cmake-helpers/DepOpenGL.cmake)
include(${PROJECT_SOURCE_DIR}/thirdparty/glfw/bk.cmake)
include(${PROJECT_SOURCE_DIR}/thirdparty/SDL2/bk.cmake)

function(link_imgui_opengl3_sdl2 target MOD)
    target_link_libraries(${target} ${MOD} ${PROJECT_SOURCE_DIR}/thirdparty/imgui/lib/libimgui_opengl3_sdl2.a)
    target_include_directories(${target} SYSTEM ${MOD} 
        ${PROJECT_SOURCE_DIR}/thirdparty/imgui/include
        ${PROJECT_SOURCE_DIR}/thirdparty/imgui/include/backends
    )
    link_opengl(${target} PUBLIC)
    link_sdl2(${target} PUBLIC)
endfunction()

function(link_imgui_opengl3_glfw target MOD)
    target_link_libraries(${target} ${MOD} ${PROJECT_SOURCE_DIR}/thirdparty/imgui/lib/libimgui_opengl3_glfw.a)
    target_include_directories(${target} SYSTEM ${MOD} 
        ${PROJECT_SOURCE_DIR}/thirdparty/imgui/include
        ${PROJECT_SOURCE_DIR}/thirdparty/imgui/include/backends
    )
    link_opengl(${target} PUBLIC)
    link_glfw(${target} PUBLIC)
endfunction()

