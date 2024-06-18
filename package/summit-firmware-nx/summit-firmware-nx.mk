ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_FIRMWARE_NX_VERSION = $(SUMMIT_NX_RADIO_STACK_VERSION_VALUE)
SUMMIT_FIRMWARE_NX_SOURCE = summit-nx61x-firmware-$(SUMMIT_FIRMWARE_NX_VERSION).tar.bz2
SUMMIT_FIRMWARE_NX_STRIP_COMPONENTS = 0
SUMMIT_FIRMWARE_NX_LICENSE = NXP, Ezurio
SUMMIT_FIRMWARE_NX_LICENSE_FILES = LICENSE.nxp2 LICENSE.ezurio

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  SUMMIT_FIRMWARE_NX_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/firmware/$(SUMMIT_FIRMWARE_NX_VERSION)
else ifeq ($(MSD_BINARIES_SOURCE_LOCATION),local)
  SUMMIT_FIRMWARE_NX_VERSION = 0.$(BR2_SUMMIT_BRANCH).0.0
  BR_NO_CHECK_HASH_FOR += $(SUMMIT_FIRMWARE_NX_DOWNLOADS)
  SUMMIT_FIRMWARE_NX_SITE = file://$(BASE_DIR)/../firmware/images
else
  SUMMIT_FIRMWARE_NX_SITE = $(SUMMIT_RADIO_URI_BASE_NX)-$(SUMMIT_FIRMWARE_NX_VERSION)
endif

define SUMMIT_FIRMWARE_NX_INSTALL_TARGET_CMDS
  rsync -rlpDWK --no-perms --inplace $(@D)/lib $(TARGET_DIR)/lib
endef

endif

$(eval $(generic-package))
