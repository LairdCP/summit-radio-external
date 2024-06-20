ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_FIRMWARE_MSD_VERSION = $(call qstrip,$(SUMMIT_MSD_RADIO_STACK_VERSION_VALUE))
SUMMIT_FIRMWARE_MSD_SOURCE = $(firstword $(SUMMIT_FIRMWARE_MSD_DOWNLOADS))
SUMMIT_FIRMWARE_MSD_EXTRA_DOWNLOADS = $(filter-out $(SUMMIT_FIRMWARE_MSD_SOURCE),$(SUMMIT_FIRMWARE_MSD_DOWNLOADS))
SUMMIT_FIRMWARE_MSD_STRIP_COMPONENTS = 0
SUMMIT_FIRMWARE_MSD_LICENSE = Atheros/QCA, Ezurio
SUMMIT_FIRMWARE_MSD_LICENSE_FILES = LICENSE.atheros LICENSE.ezurio

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  SUMMIT_FIRMWARE_MSD_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/firmware/$(SUMMIT_FIRMWARE_MSD_VERSION)
else ifeq ($(MSD_BINARIES_SOURCE_LOCATION),local)
  SUMMIT_FIRMWARE_MSD_VERSION = 0.$(BR2_SUMMIT_BRANCH).0.0
  BR_NO_CHECK_HASH_FOR += $(SUMMIT_FIRMWARE_MSD_DOWNLOADS)
  SUMMIT_FIRMWARE_MSD_SITE = file://$(BASE_DIR)/../firmware/images
else
  SUMMIT_FIRMWARE_MSD_SITE = $(SUMMIT_RADIO_URI_BASE_MSD)-$(SUMMIT_FIRMWARE_MSD_VERSION)
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_MSD_45),y)
SUMMIT_FIRMWARE_MSD_DOWNLOADS += summit-ath6k-6003-firmware-$(SUMMIT_FIRMWARE_MSD_VERSION).tar.bz2
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_MSD_50),y)
SUMMIT_FIRMWARE_MSD_DOWNLOADS += summit-ath6k-6004-firmware-$(SUMMIT_FIRMWARE_MSD_VERSION).tar.bz2
endif

define SUMMIT_FIRMWARE_MSD_EXTRACT_HOOK
	$(foreach n,$(SUMMIT_FIRMWARE_MSD_EXTRA_DOWNLOADS),tar -xjf $($(PKG)_DL_DIR)/$(n) -C $(@D) --keep-directory-symlink --no-overwrite-dir $(sep))
endef

SUMMIT_FIRMWARE_MSD_POST_EXTRACT_HOOKS += SUMMIT_FIRMWARE_MSD_EXTRACT_HOOK

define SUMMIT_FIRMWARE_MSD_INSTALL_TARGET_CMDS
  rsync -rlpDWK --no-perms --inplace $(@D)/lib $(TARGET_DIR)
endef

endif

$(eval $(generic-package))
