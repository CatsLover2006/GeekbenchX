TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
BUNDLE_NAME = ca.litten.geekbenchx

archs= armv7 armv6

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GeekbenchX

iTunesStoreX_FILES = Tweak.x CustomURLProtocol.m
iTunesStoreX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

