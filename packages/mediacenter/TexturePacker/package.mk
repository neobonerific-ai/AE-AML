# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="TexturePacker"
PKG_VERSION="0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL=""
PKG_DEPENDS_HOST="lzo:host libpng:host libjpeg-turbo:host giflib:host"
PKG_NEED_UNPACK="$(get_pkg_directory $MEDIACENTER)"
PKG_LONGDESC="kodi-platform:"

PKG_TOOLCHAIN="cmake"
PKG_CMAKE_SCRIPT="$(get_build_dir $MEDIACENTER)/tools/depends/native/TexturePacker/CMakeLists.txt"

# TexturePacker's CMakeLists.txt calls find_package(Lzo2/GIF). Those
# find-modules live in kodi's cmake/modules, not in TexturePacker's own
# tree, so the standalone host build fails to resolve lzo/gif
# (find_package(Lzo2) error). Point CMAKE_MODULE_PATH at kodi's
# cmake/modules; png/jpeg are resolved by CMake's built-in find-modules.
PKG_CMAKE_OPTS_HOST="-DCMAKE_MODULE_PATH=$(get_build_dir $MEDIACENTER)/cmake/modules -Wno-dev"

pre_configure_host() {
  export CXXFLAGS="$CXXFLAGS -std=c++11 -DTARGET_POSIX -DTARGET_LINUX -D_LINUX -I$(get_build_dir $MEDIACENTER)/xbmc/platform/linux"
  # Fix source/include paths in TexturePacker CMakeLists.txt for standalone host build.
  # When built as standalone host project, CMAKE_SOURCE_DIR points to the TexturePacker
  # subdir, not the kodi root, so add_executable fails ('Cannot find source file .../xbmc/guilib/XBTF.cpp').
  # The kodi-100.29 patch may fail to apply due to indentation differences in the kodi
  # commit being built; sed here guarantees the fix regardless of patch application result.
  sed -i 's|\${CMAKE_SOURCE_DIR}/xbmc/guilib/XBTF.cpp|\${CMAKE_CURRENT_SOURCE_DIR}/../../../../xbmc/guilib/XBTF.cpp|g' \
    $(get_build_dir $MEDIACENTER)/tools/depends/native/TexturePacker/CMakeLists.txt
  sed -i 's|\${CMAKE_SOURCE_DIR}/xbmc|\${CMAKE_CURRENT_SOURCE_DIR}/../../../../xbmc|g' \
    $(get_build_dir $MEDIACENTER)/tools/depends/native/TexturePacker/CMakeLists.txt
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp TexturePacker $TOOLCHAIN/bin
}
