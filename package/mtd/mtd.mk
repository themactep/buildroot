################################################################################
#
# mtd
#
################################################################################

MTD_VERSION = 2.3.0
MTD_SOURCE = mtd-utils-$(MTD_VERSION).tar.bz2
MTD_SITE = https://infraroot.at/pub/mtd
MTD_LICENSE = GPL-2.0
MTD_LICENSE_FILES = COPYING
MTD_CPE_ID_VENDOR = mtd-utils_project
MTD_CPE_ID_PRODUCT = mtd-utils
MTD_INSTALL_STAGING = YES
MTD_DEPENDENCIES = host-pkgconf

MTD_LDFLAGS = $(TARGET_LDFLAGS)

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
MTD_DEPENDENCIES += libexecinfo
MTD_LDFLAGS += -lexecinfo
endif

ifeq ($(BR2_PACKAGE_LZO),y)
MTD_DEPENDENCIES += lzo
MTD_CONF_OPTS += --with-lzo
else
MTD_CONF_OPTS += --without-lzo
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
MTD_DEPENDENCIES += zlib
MTD_CONF_OPTS += --with-zlib
else
MTD_CONF_OPTS += --without-zlib
endif

MTD_CONF_ENV += LDFLAGS="$(MTD_LDFLAGS)"

ifeq ($(BR2_PACKAGE_MTD_JFFS_UTILS),y)
MTD_CONF_OPTS += --with-jffs
else
MTD_CONF_OPTS += --without-jffs
endif

ifeq ($(BR2_PACKAGE_MTD_UBIFS_UTILS),y)
MTD_DEPENDENCIES += util-linux
MTD_CONF_OPTS += --with-ubifs
# crypto needs linux/hash_info.h
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_12)$(BR2_PACKAGE_OPENSSL),yy)
MTD_DEPENDENCIES += openssl
MTD_CONF_OPTS += --with-crypto
else
MTD_CONF_OPTS += --without-crypto
endif
ifeq ($(BR2_PACKAGE_ZSTD),y)
MTD_DEPENDENCIES += zstd
MTD_CONF_OPTS += --with-zstd
else
MTD_CONF_OPTS += --without-zstd
endif
else
MTD_CONF_OPTS += --without-ubifs
endif

ifeq ($(BR2_PACKAGE_MTD_UBIHEALTHD),y)
MTD_CONF_OPTS += --enable-ubihealthd
else
MTD_CONF_OPTS += --disable-ubihealthd
endif

ifeq ($(BR2_PACKAGE_MTD_TESTS),y)
MTD_CONF_OPTS += --with-tests
else
MTD_CONF_OPTS += --without-tests
endif

# If extended attributes are required, the acl package must
# also be enabled which will also include the attr package.
ifeq ($(BR2_PACKAGE_ACL),y)
MTD_DEPENDENCIES += acl
MTD_CONF_OPTS += --with-xattr
else
MTD_CONF_OPTS += --without-xattr
endif

HOST_MTD_DEPENDENCIES = host-pkgconf host-acl host-zlib host-lzo host-util-linux host-zstd
HOST_MTD_CONF_OPTS = \
	--with-jffs \
	--with-ubifs \
	--without-crypto \
	--without-tests

MKFS_JFFS2 = $(HOST_DIR)/sbin/mkfs.jffs2
SUMTOOL = $(HOST_DIR)/sbin/sumtool

MTD_TARGETS_$(BR2_PACKAGE_MTD_DOCFDISK)		+= docfdisk
MTD_TARGETS_$(BR2_PACKAGE_MTD_DOC_LOADBIOS)	+= doc_loadbios
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASHCP)		+= flashcp
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_ERASE)	+= flash_erase
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_LOCK)	+= flash_lock
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_OTP_DUMP)	+= flash_otp_dump
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_OTP_INFO)	+= flash_otp_info
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_OTP_LOCK)	+= flash_otp_lock
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_OTP_WRITE)	+= flash_otp_write
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_OTP_ERASE)	+= flash_otp_erase
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_UNLOCK)	+= flash_unlock
MTD_TARGETS_$(BR2_PACKAGE_MTD_FTL_CHECK)	+= ftl_check
MTD_TARGETS_$(BR2_PACKAGE_MTD_FTL_FORMAT)	+= ftl_format
MTD_TARGETS_$(BR2_PACKAGE_MTD_JFFS2DUMP)	+= jffs2dump
MTD_TARGETS_$(BR2_PACKAGE_MTD_LSMTD)		+= lsmtd
MTD_TARGETS_$(BR2_PACKAGE_MTD_MKFSJFFS2)	+= mkfs.jffs2
MTD_TARGETS_$(BR2_PACKAGE_MTD_MTD_DEBUG)	+= mtd_debug
MTD_TARGETS_$(BR2_PACKAGE_MTD_MTDPART)		+= mtdpart
MTD_TARGETS_$(BR2_PACKAGE_MTD_NANDDUMP)		+= nanddump
MTD_TARGETS_$(BR2_PACKAGE_MTD_NANDTEST)		+= nandtest
MTD_TARGETS_$(BR2_PACKAGE_MTD_NANDWRITE)	+= nandwrite
MTD_TARGETS_$(BR2_PACKAGE_MTD_NFTLDUMP)		+= nftldump
MTD_TARGETS_$(BR2_PACKAGE_MTD_NFTL_FORMAT)	+= nftl_format
MTD_TARGETS_$(BR2_PACKAGE_MTD_RECV_IMAGE)	+= recv_image
MTD_TARGETS_$(BR2_PACKAGE_MTD_RFDDUMP)		+= rfddump
MTD_TARGETS_$(BR2_PACKAGE_MTD_RFDFORMAT)	+= rfdformat
MTD_TARGETS_$(BR2_PACKAGE_MTD_SERVE_IMAGE)	+= serve_image
MTD_TARGETS_$(BR2_PACKAGE_MTD_SUMTOOL)		+= sumtool
MTD_TARGETS_$(BR2_PACKAGE_MTD_MTDINFO)		+= mtdinfo
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIATTACH)	+= ubiattach
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBICRC32)		+= ubicrc32
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIDETACH)	+= ubidetach
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIFORMAT)	+= ubiformat
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIHEALTHD)	+= ubihealthd
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIMKVOL)		+= ubimkvol
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBINFO)		+= ubinfo
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBINIZE)		+= ubinize
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIRENAME)	+= ubirename
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIRMVOL)		+= ubirmvol
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIRSVOL)		+= ubirsvol
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIUPDATEVOL)	+= ubiupdatevol
MTD_TARGETS_$(BR2_PACKAGE_MTD_UBIBLOCK)		+= ubiblock
MTD_TARGETS_$(BR2_PACKAGE_MTD_MKFSUBIFS)	+= mkfs.ubifs
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_READTEST)	+= flash_readtest
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_SPEED)	+= flash_speed
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_STRESS)	+= flash_stress
MTD_TARGETS_$(BR2_PACKAGE_MTD_FLASH_TORTURE)	+= flash_torture
MTD_TARGETS_$(BR2_PACKAGE_MTD_INTEGCK)		+= integck
MTD_TARGETS_$(BR2_PACKAGE_MTD_NANDBITERRS)	+= nandbiterrs
MTD_TARGETS_$(BR2_PACKAGE_MTD_NANDPAGETEST)	+= nandpagetest
MTD_TARGETS_$(BR2_PACKAGE_MTD_NANDSUBPAGETEST)	+= nandsubpagetest
MTD_TARGETS_$(BR2_PACKAGE_MTD_NANDFLIPBITS)	+= nandflipbits

define MTD_INSTALL_TARGET_CMDS
	$(foreach f,$(MTD_TARGETS_y), \
		$(INSTALL) -D -m 0755 $(@D)/$(f) $(TARGET_DIR)/usr/sbin/$(notdir $(f))
	)
endef

# Those libraries are not installed by "make install", but are needed
# by other packages, such as swupdate.
define MTD_INSTALL_LIBS
	$(INSTALL) -D -m 0755 $(@D)/include/libmtd.h $(STAGING_DIR)/usr/include/libmtd.h
	$(INSTALL) -D -m 0755 $(@D)/include/libubi.h $(STAGING_DIR)/usr/include/libubi.h
	$(INSTALL) -D -m 0755 $(@D)/include/mtd/ubi-media.h $(STAGING_DIR)/usr/include/mtd/ubi-media.h
	$(INSTALL) -D -m 0755 $(@D)/libmtd.a $(STAGING_DIR)/usr/lib/libmtd.a
	$(INSTALL) -D -m 0755 $(@D)/libubi.a $(STAGING_DIR)/usr/lib/libubi.a
endef

MTD_POST_INSTALL_STAGING_HOOKS += MTD_INSTALL_LIBS

$(eval $(autotools-package))
$(eval $(host-autotools-package))
