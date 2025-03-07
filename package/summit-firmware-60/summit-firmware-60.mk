ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_FIRMWARE_60_VERSION = $(call qstrip,$(SUMMIT_60_RADIO_STACK_VERSION_VALUE))
SUMMIT_FIRMWARE_60_SOURCE = $(firstword $(SUMMIT_FIRMWARE_60_DOWNLOADS))
SUMMIT_FIRMWARE_60_EXTRA_DOWNLOADS = $(filter-out $(SUMMIT_FIRMWARE_60_SOURCE),$(SUMMIT_FIRMWARE_60_DOWNLOADS))
SUMMIT_FIRMWARE_60_STRIP_COMPONENTS = 0
SUMMIT_FIRMWARE_60_LICENSE = NXP, Ezurio
SUMMIT_FIRMWARE_60_LICENSE_FILES = LICENSE.nxp1 LICENSE.ezurio

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  SUMMIT_FIRMWARE_60_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/firmware/$(SUMMIT_FIRMWARE_60_VERSION)
else ifeq ($(MSD_BINARIES_SOURCE_LOCATION),local)
  SUMMIT_FIRMWARE_60_VERSION = 0.$(BR2_SUMMIT_BRANCH).0.0
  BR_NO_CHECK_HASH_FOR += $(SUMMIT_FIRMWARE_60_DOWNLOADS)
  SUMMIT_FIRMWARE_60_SITE = file://$(BASE_DIR)/../firmware/images
else
  SUMMIT_FIRMWARE_60_SITE = $(SUMMIT_RADIO_URI_BASE_60)-$(SUMMIT_FIRMWARE_60_VERSION)
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_60_SDIO_UART),y)
SUMMIT_FIRMWARE_60_PKGS += sdio-uart
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_60_SDIO_SDIO),y)
SUMMIT_FIRMWARE_60_PKGS += sdio-sdio
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_60_PCIE_UART),y)
SUMMIT_FIRMWARE_60_PKGS += pcie-uart
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_60_PCIE_USB),y)
SUMMIT_FIRMWARE_60_PKGS += pcie-usb
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_60_USB_USB),y)
SUMMIT_FIRMWARE_60_PKGS += usb-usb
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_60_SOM8MP),y)
SUMMIT_FIRMWARE_60_DOWNLOADS += summit-som8mp-radio-firmware-$(SUMMIT_FIRMWARE_60_VERSION).tar.bz2
endif

SUMMIT_FIRMWARE_60_DOWNLOADS += $(foreach n,$(SUMMIT_FIRMWARE_60_PKGS),summit-60-radio-firmware-$(n)-$(SUMMIT_FIRMWARE_60_VERSION).tar.bz2)

define SUMMIT_FIRMWARE_60_EXTRACT_HOOK
	$(foreach n,$(SUMMIT_FIRMWARE_60_EXTRA_DOWNLOADS),tar -xjf $($(PKG)_DL_DIR)/$(n) -C $(@D) --keep-directory-symlink --no-overwrite-dir $(sep))
endef

SUMMIT_FIRMWARE_60_POST_EXTRACT_HOOKS += SUMMIT_FIRMWARE_60_EXTRACT_HOOK

define SUMMIT_FIRMWARE_60_INSTALL_TARGET_CMDS
  rsync -rlpDWK --no-perms --inplace $(@D)/lib $(TARGET_DIR)
endef

endif

$(eval $(generic-package))
