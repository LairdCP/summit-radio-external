SUMMIT_MFG60N_VERSION = $(SUMMIT_60_RADIO_STACK_VERSION_VALUE)
SUMMIT_MFG60N_SOURCE = mfg60n-$(SUMMIT_RADIO_STACK_ARCH)-$(SUMMIT_MFG60N_VERSION).tar.bz2
SUMMIT_MFG60N_STRIP_COMPONENTS = 0
SUMMIT_MFG60N_LICENSE = GPL-2.0

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
SUMMIT_MFG60N_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/mfg60n/laird/$(SUMMIT_MFG60N_VERSION)
else ifneq ($(SUMMIT_SOM_URI_BASE_ARCHIVE),)
SUMMIT_MFG60N_SITE = $(SUMMIT_SOM_URI_BASE_ARCHIVE)-$(SUMMIT_MFG60N_VERSION)
else
SUMMIT_MFG60N_SITE = $(SUMMIT_RADIO_URI_BASE_60)-$(SUMMIT_MFG60N_VERSION)
endif

define SUMMIT_MFG60N_POST_EXTRACT
	(cd $(@D) && ./$(SUMMIT_MFG60N_SOURCE:%.tar.bz2=%.sh) tar)
	tar -xvjf $(@D)/$(SUMMIT_MFG60N_SOURCE) -C $(@D)
	rm $(@D)/$(SUMMIT_MFG60N_SOURCE) $(@D)/$(SUMMIT_MFG60N_SOURCE:%.tar.bz2=%.sh) $(@D)/$(SUMMIT_MFG60N_SOURCE:%.tar.bz2=%.sha)
endef

SUMMIT_MFG60N_POST_EXTRACT_HOOKS += SUMMIT_MFG60N_POST_EXTRACT

ifeq ($(BR2_PACKAGE_SUMMIT_MFG60N_LMU),y)
define SUMMIT_MFG60N_LMU_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/lmu $(TARGET_DIR)/usr/bin/lmu
endef
endif

ifeq ($(BR2_PACKAGE_SUMMIT_MFG60N_REGULATORY),y)

ifneq ($(BR2_PACKAGE_BLUEZ5_UTILS)$(BR2_PACKAGE_BLUEZ4_UTILS),)
define SUMMIT_MFG60N_BTLRU_INSTALL_TARGET_CMD
	$(INSTALL) -D -m 755 $(@D)/btlru $(TARGET_DIR)/usr/bin/btlru
endef
endif

define SUMMIT_MFG60N_REGULATORY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 -t $(TARGET_DIR)/usr/bin $(@D)/lru 
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/lib/firmware/lrdmwl/ $(@D)/88W8997_mfg*
	$(SUMMIT_MFG60N_BTLRU_INSTALL_TARGET_CMD)
endef

endif

define SUMMIT_MFG60N_INSTALL_TARGET_CMDS
	$(SUMMIT_MFG60N_LMU_INSTALL_TARGET_CMDS)
	$(SUMMIT_MFG60N_REGULATORY_INSTALL_TARGET_CMDS)
endef

$(eval $(generic-package))
