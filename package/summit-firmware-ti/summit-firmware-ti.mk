ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_FIRMWARE_TI_VERSION = $(call qstrip,$(SUMMIT_TI_RADIO_STACK_VERSION_VALUE))
SUMMIT_FIRMWARE_TI_SOURCE =
SUMMIT_FIRMWARE_TI_LICENSE = GPL-2.0
SUMMIT_FIRMWARE_TI_LICENSE_FILES = COPYING

ifeq ($(MSD_60_SOURCE_LOCATION),laird_internal)
  SUMMIT_FIRMWARE_TI_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/firmware/$(SUMMIT_FIRMWARE_TI_VERSION)
else
  SUMMIT_FIRMWARE_TI_SITE = $(SUMMIT_RADIO_URI_BASE_TI)-$(SUMMIT_FIRMWARE_TI_VERSION)
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_TI_351),y)
SUMMIT_FIRMWARE_TI_EXTRA_DOWNLOADS += summit-ti351-firmware-$(SUMMIT_FIRMWARE_TI_VERSION).tar.bz2
endif

define SUMMIT_FIRMWARE_TI_INSTALL_TARGET_CMDS
	$(foreach n,$(SUMMIT_FIRMWARE_TI_EXTRA_DOWNLOADS),tar -xjf $($(PKG)_DL_DIR)/$(n) -C $(TARGET_DIR) --keep-directory-symlink --no-overwrite-dir --touch $(sep))
endef

endif

$(eval $(generic-package))
