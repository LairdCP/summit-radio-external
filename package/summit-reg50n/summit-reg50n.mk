SUMMIT_REG50N_VERSION = $(SUMMIT_MSD_RADIO_STACK_VERSION_VALUE)
SUMMIT_REG50N_SOURCE = reg50n-$(SUMMIT_RADIO_STACK_ARCH)-$(SUMMIT_REG50N_VERSION).tar.bz2
SUMMIT_REG50N_STRIP_COMPONENTS = 0
SUMMIT_REG50N_LICENSE = MIT

ifeq ($(MSD_BINARIES_SOURCE_LOCATION),laird_internal)
	SUMMIT_REG50N_SITE = $(SUMMIT_RADIO_URI_BASE_INTERNAL)/reg50n/laird/$(SUMMIT_REG50N_VERSION)
else
	SUMMIT_REG50N_SITE = $(SUMMIT_RADIO_URI_BASE_MSD)-$(SUMMIT_REG50N_VERSION)
endif

define SUMMIT_REG50N_POST_EXTRACT
	(cd $(@D) && ./$(SUMMIT_REG50N_SOURCE:%.tar.bz2=%.sh) tar)
	tar -xvjf $(@D)/$(SUMMIT_REG50N_SOURCE) -C $(@D)
	rm $(@D)/$(SUMMIT_REG50N_SOURCE) $(@D)/$(SUMMIT_REG50N_SOURCE:%.tar.bz2=%.sh) $(@D)/$(SUMMIT_REG50N_SOURCE:%.tar.bz2=%.sha)
endef

SUMMIT_REG50N_POST_EXTRACT_HOOKS += SUMMIT_REG50N_POST_EXTRACT

define SUMMIT_REG50N_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 -t $(TARGET_DIR)/usr/bin $(@D)/lru $(@D)/smu_cli $(@D)/tcmd.sh
	$(INSTALL) -D -m 644 -t $(TARGET_DIR)/lib/firmware/ath6k/AR6004/hw3.0/ $(@D)/files/utf*.bin
endef

$(eval $(generic-package))
