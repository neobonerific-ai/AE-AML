# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team CoreELEC (https://coreelec.org)

PKG_NAME="fakeroot"
PKG_VERSION="1.23"
PKG_SHA256="009cd6696a931562cf1c212bb57ca441a4a2d45cd32c3190a35c7ae98506f4f6"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="http://fakeroot.alioth.debian.org/"
PKG_URL="http://ftp.debian.org/debian/pool/main/f/fakeroot/${PKG_NAME}_${PKG_VERSION}.orig.tar.xz"
PKG_DEPENDS_HOST="ccache:host libcap:host"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="fakeroot: provides a fake root environment by means of LD_PRELOAD and SYSV IPC (or TCP) trickery."
PKG_LONGDESC="fakeroot provides a fake root environment by means of LD_PRELOAD and SYSV IPC (or TCP) trickery."

PKG_CONFIGURE_OPTS_HOST="--with-gnu-ld"

pre_configure_host() {
  # Modern glibc no longer defines _STAT_VER; define it for fakeroot.
  for root in "$PWD" "$PKG_BUILD" "/home/runner/work/AE-AML/AE-AML/build.AlexELEC-S812.arm" "."; do
    [ -d "$root" ] || continue
    for f in $(find "$root" -type f \( -name 'libfakeroot.c' -o -name 'faked.c' \) 2>/dev/null); do
      if ! grep -q '#define _STAT_VER 0' "$f" 2>/dev/null; then
        sed -i '1i #ifndef _STAT_VER\n#define _STAT_VER 0\n#endif' "$f"
      fi
    done
  done
  : # _STAT_VER provided via source patch above; do not pollute CFLAGS/env (breaks configure option parsing)
}
