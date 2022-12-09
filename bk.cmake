set(BK_IMGUI_VERSION "1.89.1")

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/imgui EXCLUDE_FROM_ALL)
ConfigureCompileOptions(imgui PUBLIC)

function(link_imgui target MOD)
    target_link_libraries(${target} ${MOD} imgui)
    target_include_directories(${target} SYSTEM ${MOD} ${PROJECT_SOURCE_DIR}/thirdparty/imgui)
endfunction()
