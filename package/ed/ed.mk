################################################################################
#
# ed
#
################################################################################

ED_VERSION = 1.14.1
ED_SITE = $(BR2_GNU_MIRROR)/ed
ED_SOURCE = ed-$(ED_VERSION).tar.lz
ED_CONF_OPTS = \
	CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"
ED_DEPENDENCIES = host-lzip
ED_LICENSE = GPLv3+
ED_LICENSE_FILES = COPYING

define ED_EXTRACT_CMDS
	$(HOST_DIR)/usr/bin/lzip -d -c $(DL_DIR)/$(ED_SOURCE) | \
		tar --strip-components=1 -C $(@D) $(TAR_OPTIONS) -
endef

define ED_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_MAKE_ENV) ./configure \
		--prefix=/usr \
		$(TARGET_CONFIGURE_OPTS) \
	)
endef

define ED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define ED_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(generic-package))
