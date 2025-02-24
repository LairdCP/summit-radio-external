ifneq ($(BR2_LRD_DEVEL_BUILD),y)

SUMMIT_REGIF513_VERSION = $(SUMMIT_LWB_RADIO_STACK_VERSION_VALUE)
SUMMIT_REGIF513_SOURCE = regIF513-$(SUMMIT_RADIO_STACK_ARCH)-$(SUMMIT_REGIF513_VERSION).tar.bz2
SUMMIT_REGIF513_STRIP_COMPONENTS = 0
SUMMIT_REGIF513_LICENSE = Ezurio Cypress
SUMMIT_REGIF513_LICENSE_FILES = LICENSE.ezurio FOSS_README.txt

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
  SUMMIT_REGIF513_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/regIF513/laird/$(SUMMIT_REGIF513_VERSION)
else ifeq ($(MSD_BINARIES_SOURCE_LOCATION),local)
  SUMMIT_REGIF513_VERSION = 0.$(BR2_SUMMIT_BRANCH).0.0
  BR_NO_CHECK_HASH_FOR += $(SUMMIT_REGIF513_SOURCE)
  SUMMIT_REGIF513_SITE = file://$(BASE_DIR)/../regLWB-$(SUMMIT_RADIO_STACK_ARCH)/images
else
  SUMMIT_REGIF513_SITE = $(SUMMIT_RADIO_URI_BASE_LWB)-$(SUMMIT_REGIF513_VERSION)
endif

define SUMMIT_REGIF513_POST_EXTRACT
	(cd $(@D) && ./$(SUMMIT_REGIF513_SOURCE:%.tar.bz2=%.sh) tar)
	tar -xvjf $(@D)/$(SUMMIT_REGIF513_SOURCE) -C $(@D)
	rm $(@D)/$(SUMMIT_REGIF513_SOURCE) $(@D)/$(SUMMIT_REGIF513_SOURCE:%.tar.bz2=%.sh) $(@D)/$(SUMMIT_REGIF513_SOURCE:%.tar.bz2=%.sha)
endef

SUMMIT_REGIF513_POST_EXTRACT_HOOKS += SUMMIT_REGIF513_POST_EXTRACT

ifneq ($(BR2_PACKAGE_BLUEZ5_UTILS)$(BR2_PACKAGE_BLUEZ4_UTILS),)
define SUMMIT_REGIF513_BTLRU_INSTALL_TARGET_CMD
	$(INSTALL) -D -m 755 -t $(TARGET_DIR)/usr/bin $(@D)/btlru 
endef
endif

define SUMMIT_REGIF513_INSTALL_TARGET_CMDS
	$(SUMMIT_REGIF513_BTLRU_INSTALL_TARGET_CMD)
	$(INSTALL) -D -m 775 -t $(TARGET_DIR)/usr/bin $(@D)/lru
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/lib/firmware/cypress $(@D)/cyfmac*
endef

endif

$(eval $(generic-package))
