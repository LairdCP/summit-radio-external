ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_FIRMWARE_LWB_IF_VERSION = $(call qstrip,$(SUMMIT_LWB_RADIO_STACK_VERSION_VALUE))
SUMMIT_FIRMWARE_LWB_IF_SOURCE = $(firstword $(SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS))
SUMMIT_FIRMWARE_LWB_IF_EXTRA_DOWNLOADS = $(filter-out $(SUMMIT_FIRMWARE_LWB_IF_SOURCE),$(SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS))
SUMMIT_FIRMWARE_LWB_IF_STRIP_COMPONENTS = 0
SUMMIT_FIRMWARE_LWB_IF_LICENSE = Ezurio
SUMMIT_FIRMWARE_LWB_IF_LICENSE_FILES = LICENSE

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  SUMMIT_FIRMWARE_LWB_IF_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/firmware/$(SUMMIT_FIRMWARE_LWB_IF_VERSION)
else
  SUMMIT_FIRMWARE_LWB_IF_SITE = $(SUMMIT_RADIO_URI_BASE_LWB)-$(SUMMIT_FIRMWARE_LWB_IF_VERSION)
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB_FCC),y)
SUMMIT_FIRMWARE_LWB_IF_LWB_PKGS += fcc
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB_ETSI),y)
SUMMIT_FIRMWARE_LWB_IF_LWB_PKGS += etsi
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB_JP),y)
SUMMIT_FIRMWARE_LWB_IF_LWB_PKGS += jp
endif

SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS += $(foreach n,$(SUMMIT_FIRMWARE_LWB_IF_LWB_PKGS),summit-lwb-$(n)-firmware-$(SUMMIT_FIRMWARE_LWB_IF_VERSION).tar.bz2)

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5_FCC),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5_PKGS += fcc
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5_IC),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5_PKGS += ic
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5_ETSI),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5_PKGS += etsi
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5_JP),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5_PKGS += jp
endif

SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS += $(foreach n,$(SUMMIT_FIRMWARE_LWB_IF_LWB5_PKGS),summit-lwb5-$(n)-firmware-$(SUMMIT_FIRMWARE_LWB_IF_VERSION).tar.bz2)

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_SDIO_DIV),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_PKGS += sdio-div
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_SDIO_SA),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_PKGS += sdio-sa
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_SDIO_SA_M2),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_PKGS += sdio-sa-m2
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_USB_DIV),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_PKGS += usb-div
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_USB_SA),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_PKGS += usb-sa
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_USB_SA_M2),y)
SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_PKGS += usb-sa-m2
endif

SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS += $(foreach n,$(SUMMIT_FIRMWARE_LWB_IF_LWB5PLUS_PKGS),summit-lwb5plus-$(n)-firmware-$(SUMMIT_FIRMWARE_LWB_IF_VERSION).tar.bz2)

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_LWBPLUS),y)
SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS += summit-lwbplus-firmware-$(SUMMIT_FIRMWARE_LWB_IF_VERSION).tar.bz2
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_IF573_SDIO),y)
SUMMIT_FIRMWARE_LWB_IF_IF573_PKGS += sdio
endif

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_IF573_PCIE),y)
SUMMIT_FIRMWARE_LWB_IF_IF573_PKGS += pcie
endif

SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS += $(foreach n,$(SUMMIT_FIRMWARE_LWB_IF_IF573_PKGS),summit-if573-$(n)-firmware-$(SUMMIT_FIRMWARE_LWB_IF_VERSION).tar.bz2)

ifeq ($(BR2_PACKAGE_SUMMIT_FIRMWARE_LWB_IF_IF513),y)
SUMMIT_FIRMWARE_LWB_IF_DOWNLOADS += summit-if513-firmware-$(SUMMIT_FIRMWARE_LWB_IF_VERSION).tar.bz2
endif

define SUMMIT_FIRMWARE_LWB_IF_EXTRACT_HOOK
	$(foreach n,$(SUMMIT_FIRMWARE_LWB_IF_EXTRA_DOWNLOADS),tar -xjf $($(PKG)_DL_DIR)/$(n) -C $(@D) --keep-directory-symlink --no-overwrite-dir $(sep))
endef

SUMMIT_FIRMWARE_LWB_IF_POST_EXTRACT_HOOKS += SUMMIT_FIRMWARE_LWB_IF_EXTRACT_HOOK

define SUMMIT_FIRMWARE_LWB_IF_INSTALL_TARGET_CMDS
  rsync -rlpDWK --no-perms --inplace --exclude '.*' --exclude LICENSE $(@D) $(TARGET_DIR)/
endef

endif

$(eval $(generic-package))
