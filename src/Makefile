TARGET := iphone:clang:7.1:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
BUNDLE_NAME = ca.litten.geekbenchx

archs= armv7 armv6

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GeekbenchX

GeekbenchX_FILES = Tweak.x
GeekbenchX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

