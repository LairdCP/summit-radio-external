################################################################################
#
# summit-brcm-patchram-plus
#
################################################################################

SUMMIT_BRCM_PATCHRAM_PLUS_VERSION = $(SUMMIT_LWB_RADIO_STACK_VERSION_VALUE)
SUMMIT_BRCM_PATCHRAM_PLUS_LICENSE = Apache-2.0
SUMMIT_BRCM_PATCHRAM_PLUS_LICENSE_FILES = LICENSE

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  SUMMIT_BRCM_PATCHRAM_PLUS_SITE = https://github.com/rfpros/cp_linux-brcm_patchram.git
  SUMMIT_BRCM_PATCHRAM_PLUS_SITE_METHOD = git
else
  SUMMIT_BRCM_PATCHRAM_PLUS_SITE = $(call github,LairdCP,brcm_patchram,LRD-REL-$(SUMMIT_BRCM_PATCHRAM_PLUS_VERSION))
endif

ifeq ($(BR2_PACKAGE_BLUEZ4_UTILS),y)
SUMMIT_BRCM_PATCHRAM_PLUS_DEPENDENCIES = bluez4_utils
else
SUMMIT_BRCM_PATCHRAM_PLUS_DEPENDENCIES = bluez5_utils
endif

define SUMMIT_BRCM_PATCHRAM_PLUS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) brcm_patchram_plus
endef

define SUMMIT_BRCM_PATCHRAM_PLUS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 -t $(TARGET_DIR)/usr/bin/ $(@D)/brcm_patchram_plus
endef

$(eval $(generic-package))
