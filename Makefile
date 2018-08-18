include $(THEOS)/makefiles/common.mk

TWEAK_NAME = gif2ani2
gif2ani2_FILES = Tweak.xm UIImage+animatedGIF.m G2PreferencesManager.m
gif2ani2_FRAMEWORKS = UIKIT ImageIO
gif2ani2_CFLAGS = -fobjc-arc
gif2ani2_EXTRA_FRAMEWORKS = Cephei
gif2ani2_LIBRARIES = colorpicker


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += gif2aniprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
