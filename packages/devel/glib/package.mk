# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glib"
PKG_VERSION="2.53.5"
PKG_SHA256="991421f41a4ed4cc1637e5f9db0d03fd236d2cbd19f3c5b097a343bec5126602"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.gtk.org/"
PKG_URL="http://ftp.gnome.org/pub/gnome/sources/glib/${PKG_VERSION%.*}/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib libffi Python2:host util-linux"
PKG_DEPENDS_HOST="libffi:host pcre:host zlib:host"
PKG_LONGDESC="A library which includes support routines for C such as lists, trees, hashes, memory allocation."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_HOST="PCRE_LIBS=-l:libpcre.a \
                         --enable-static \
                         --disable-shared \
                         --disable-libmount \
                         --with-python=python"

# glib:host needs explicit host CFLAGS (avoid target -mtune=cortex-a9 leak on
# x86_64 hosts) plus modern-gcc tolerances. CFLAGS must be exported as an
# environment variable, NOT passed as a configure argument: scripts/build
# expands $PKG_CONFIGURE_OPTS_HOST unquoted (scripts/build:304), so a
# multi-word CFLAGS=... is word-split and -O2/-Wall/... reach configure as
# unknown flags ("unrecognized option: -O2").
pre_configure_host() {
  export CFLAGS="-march=native -O2 -Wall -pipe -I$TOOLCHAIN/include -Wno-format-security -Wno-error=format-overflow"
}
PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_snprintf_c99=yes \
                           ac_cv_func_vsnprintf_c99=yes \
                           glib_cv_stack_grows=no \
                           glib_cv_uscore=no \
                           glib_cv_va_val_copy=no \
                           --disable-selinux \
                           --disable-fam \
                           --enable-xattr \
                           --disable-libelf \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-man \
                           --disable-dtrace \
                           --disable-systemtap \
                           --enable-Bsymbolic \
                           --with-gnu-ld \
                           --with-threads=posix \
                           --with-pcre=internal \
                           --with-python=python"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/gdbus-2.0
  rm -rf $INSTALL/usr/lib/glib-2.0
  rm -rf $INSTALL/usr/share
}
