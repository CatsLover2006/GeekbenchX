TARGET := iphone:clang:5.1:3.1
INSTALL_TARGET_PROCESSES = SpringBoard
BUNDLE_NAME = ca.litten.geekbenchx

include $(THEOS)/makefiles/common.mk

ARCHS=armv6 armv7

TWEAK_NAME = GeekbenchX

GeekbenchX_FILES = Tweak.x
GeekbenchX_CFLAGS = -fobjc-arc
GeekbenchX_LDFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

