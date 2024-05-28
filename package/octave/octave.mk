################################################################################
#
# octave
#
################################################################################

OCTAVE_VERSION = 9.1.0
OCTAVE_SITE = https://ftp.gnu.org/gnu/octave
OCTAVE_SOURCE = octave-$(OCTAVE_VERSION).tar.lz
OCTAVE_LICENSE = GPL-3.0+
OCTAVE_LICENSE_FILES = COPYING
OCTAVE_AUTORECONF = YES

OCTAVE_CONF_OPTS = --disable-java

OCTAVE_DEPENDENCIES = \
	host-gperf \
	host-pkgconf \
	openblas \
	pcre2

ifeq ($(BR2_PACKAGE_READLINE),y)
OCTAVE_CONF_OPTS += \
	--enable-readline \
	--with-libreadline-prefix=$(STAGING_DIR)/usr
OCTAVE_DEPENDENCIES += readline
else
OCTAVE_CONF_OPTS += --disable-readline
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
OCTAVE_CONF_OPTS += --with-z
OCTAVE_DEPENDENCIES += zlib
else
OCTAVE_CONF_OPTS += --without-z
endif

$(eval $(autotools-package))
