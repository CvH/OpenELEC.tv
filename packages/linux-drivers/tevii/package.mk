################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="tevii"
PKG_VERSION="20141204"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tevii.com/Support.asp"
PKG_URL="http://mycvh.de/openelec/tevii-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Official Linux Tevii tuner drivers"
PKG_LONGDESC="Official Linux Tevii tuner drivers"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  # dont use our LDFLAGS, use the KERNEL LDFLAGS
  export LDFLAGS=""
}

make_target() {
  make VER=$KERNEL_VER SRCDIR=$(kernel_path) allyesconfig
  make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$KERNEL_VER/updates/media_build
  find $ROOT/$PKG_BUILD/v4l/ -name \*.ko -exec strip --strip-debug {} \;
  find $ROOT/$PKG_BUILD/v4l/ -name \*.ko -exec cp {} $INSTALL/lib/modules/$KERNEL_VER/updates/media_build \;
}
