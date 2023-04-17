#!/bin/bash
em++ \
\
-I. \
-I/usr/lib/emscripten/system/include \
\
-std=c++20 \
-s USE_SDL=2 \
-O3 \
-flto \
\
imgui.cpp \
imgui_demo.cpp \
imgui_draw.cpp \
imgui_tables.cpp \
imgui_widgets.cpp \
backends/imgui_impl_sdl.cpp \
backends/imgui_impl_opengl3.cpp \
-c

emar rcs imgui-opengl3-sdl2.bc \
imgui.o \
imgui_demo.o \
imgui_draw.o \
imgui_tables.o \
imgui_widgets.o \
imgui_impl_sdl.o \
imgui_impl_opengl3.o \

rm imgui.o
rm imgui_demo.o
rm imgui_draw.o
rm imgui_tables.o
rm imgui_widgets.o
rm imgui_impl_sdl.o
rm imgui_impl_opengl3.o
