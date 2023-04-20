#!/bin/bash
cd ..
#remove previous installation
rm -r imgui-build
rm -r imgui
mkdir imgui-build
mkdir imgui
cd imgui-build
cmake \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=../imgui \
../imgui-src
make -j 8
make install
cd ..
rm -r imgui-build
cp imgui-src/bk.cmake imgui
