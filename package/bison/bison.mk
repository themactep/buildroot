################################################################################
#
# bison
#
################################################################################

BISON_VERSION = 3.8.2
BISON_SOURCE = bison-$(BISON_VERSION).tar.xz
BISON_SITE = $(BR2_GNU_MIRROR)/bison
BISON_LICENSE = GPL-3.0+
BISON_LICENSE_FILES = COPYING
BISON_CPE_ID_VENDOR = gnu
# parallel build issue in examples/c/reccalc/
BISON_MAKE = $(MAKE1)
HOST_BISON_DEPENDENCIES = host-m4
HOST_BISON_CONF_OPTS = --enable-relocatable
# gcc-15 defaults to -std=gnu23 which breaks the bundled gnulib configure
# checks (bool/false/true became keywords in C23). Force the previous default.
HOST_BISON_CONF_ENV = \
	ac_cv_libtextstyle=no \
	CFLAGS="$(HOST_CFLAGS) -std=gnu17"

$(eval $(host-autotools-package))
