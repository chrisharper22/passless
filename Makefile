TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Passless

Passless_FILES = $(shell find Sources/Passless -name '*.swift') $(shell find Sources/PasslessC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
Passless_SWIFTFLAGS = -ISources/PasslessC/include
Passless_CFLAGS = -fobjc-arc
Passless_PRIVATE_FRAMEWORKS = SpringBoardFoundation

include $(THEOS_MAKE_PATH)/tweak.mk
