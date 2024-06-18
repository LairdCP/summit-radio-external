ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_REGLWB5PLUS_VERSION = $(SUMMIT_LWB_IF_RADIO_STACK_VERSION_VALUE)
SUMMIT_REGLWB5PLUS_SOURCE = regLWB5plus-$(SUMMIT_RADIO_STACK_ARCH)-$(SUMMIT_REGLWB5PLUS_VERSION).tar.bz2
SUMMIT_REGLWB5PLUS_STRIP_COMPONENTS = 0
SUMMIT_REGLWB5PLUS_LICENSE = Ezurio Cypress
SUMMIT_REGLWB5PLUS_LICENSE_FILES = LICENSE.ezurio FOSS_README.txt

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  SUMMIT_REGLWB5PLUS_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/regLWB5plus/laird/$(SUMMIT_REGLWB5PLUS_VERSION)
else ifeq ($(MSD_BINARIES_SOURCE_LOCATION),local)
  SUMMIT_REGLWB5PLUS_VERSION = 0.$(BR2_SUMMIT_BRANCH).0.0
  BR_NO_CHECK_HASH_FOR += $(SUMMIT_REGLWB5PLUS_SOURCE)
  SUMMIT_REGLWBPLUS_SITE = file://$(BASE_DIR)/../regLWB-$(SUMMIT_RADIO_STACK_ARCH)/images
else
  SUMMIT_REGLWB5PLUS_SITE = $(SUMMIT_RADIO_URI_BASE_LWB)-$(SUMMIT_REGLWB5PLUS_VERSION)
endif

define SUMMIT_REGLWB5PLUS_POST_EXTRACT
	(cd $(@D) && ./$(SUMMIT_REGLWB5PLUS_SOURCE:%.tar.bz2=%.sh) tar)
	tar -xvjf $(@D)/$(SUMMIT_REGLWB5PLUS_SOURCE) -C $(@D)
	rm $(@D)/$(SUMMIT_REGLWB5PLUS_SOURCE) $(@D)/$(SUMMIT_REGLWB5PLUS_SOURCE:%.tar.bz2=%.sh) $(@D)/$(SUMMIT_REGLWB5PLUS_SOURCE:%.tar.bz2=%.sha)
endef

SUMMIT_REGLWB5PLUS_POST_EXTRACT_HOOKS += SUMMIT_REGLWB5PLUS_POST_EXTRACT

ifneq ($(BR2_PACKAGE_BLUEZ5_UTILS)$(BR2_PACKAGE_BLUEZ4_UTILS),)
define SUMMIT_REGLWB5PLUS_BTLRU_INSTALL_TARGET_CMD
	$(INSTALL) -D -m 755 -t $(TARGET_DIR)/usr/bin $(@D)/btlru 
endef
endif

define SUMMIT_REGLWB5PLUS_INSTALL_TARGET_CMDS
	$(SUMMIT_REGLWB5PLUS_BTLRU_INSTALL_TARGET_CMD)
	$(INSTALL) -D -m 775 -t $(TARGET_DIR)/usr/bin $(@D)/lru
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/lib/firmware/brcfmac $(@D)/brcmfmac*
endef

endif

$(eval $(generic-package))
