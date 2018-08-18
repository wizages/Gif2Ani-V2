include $(THEOS)/makefiles/common.mk

SDKVERSION = 9.3
SYSROOT = $(THEOS)/sdks/iPhoneOS9.3.sdk
BUNDLE_NAME = gif2aniprefs
gif2aniprefs_FILES = gif2ani2RootListController.m HBColorPickerCell.m
gif2aniprefs_INSTALL_PATH = /Library/PreferenceBundles
gif2aniprefs_FRAMEWORKS = UIKit
gif2aniprefs_PRIVATE_FRAMEWORKS = Preferences AppSupport
gif2aniprefs_EXTRA_FRAMEWORKS = CepheiPrefs Cephei
gif2aniprefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/gif2aniprefs.plist$(ECHO_END)
