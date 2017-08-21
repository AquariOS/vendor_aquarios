PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest 

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Default sounds
PRODUCT_PROPERTY_OVERRIDES += \\
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aquarios/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aquarios/prebuilt/common/bin/50-aquarios.sh:system/addon.d/50-aquarios.sh

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# AQUARIOS-specific init file
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/init.local.rc:root/init.aquarios.rc

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/aquarios/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/aquarios/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/aquarios/prebuilt/common/bin/sysinit:system/bin/sysinit

# debug packages
ifneq ($(TARGET_BUILD_VARIENT),user)
PRODUCT_PACKAGES += \
    Development
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/slim/config/twrp.mk
endif

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Build Magisk root method (NEEDS DEVICE FLAG)
ifneq ($(DEFAULT_ROOT_METHOD),Magisk)
PRODUCT_PACKAGES += \
    MagiskManager
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/zip/magisk.zip:system/addon.d/magisk.zip
endif

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

#SnapdragonGallery
PRODUCT_PACKAGES += \
    SnapdragonGallery

# Extra Optional packages
PRODUCT_PACKAGES += \
    AquariOSBootAnimation \
    AquariosWallpaperResizer \
    Nova \
    ThemeInterfacer \
    Substratum \
    LatinIME \
    BluetoothExt \
    OmniJaws \
    OmniStyle \
    WallpaperPicker \
    LiveWallpapersPicker

# Include explicitly to work around Facelock issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full

## Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/aquarios/overlay/common \
    vendor/aquarios/overlay/dictionaries

# Versioning System
# AquariOS version.
PRODUCT_VERSION_MAJOR = $(PLATFORM_VERSION)
PRODUCT_VERSION_MINOR = r
PRODUCT_VERSION_MAINTENANCE = 29
ifdef AQUARIOS_BUILD_EXTRA
    AQUARIOS_POSTFIX := -$(AQUARIOS_BUILD_EXTRA)
endif

ifndef AQUARIOS_BUILD_TYPE
    AQUARIOS_BUILD_TYPE := UNOFFICIAL
endif

ifeq ($(AQUARIOS_BUILD_TYPE),DM)
    AQUARIOS_POSTFIX := -$(shell date +"%Y%m%d")
endif

ifndef AQUARIOS_POSTFIX
    AQUARIOS_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Set all versions
AQUARIOS_VERSION := AquariOS-$(PRODUCT_VERSION_MAJOR)_$(PRODUCT_VERSION_MINOR)$(PRODUCT_VERSION_MAINTENANCE)-$(AQUARIOS_BUILD_TYPE)$(AQUARIOS_POSTFIX)
AQUARIOS_MOD_VERSION := AquariOS-$(AQUARIOS_BUILD)-$(PRODUCT_VERSION_MAJOR)_$(PRODUCT_VERSION_MINOR)$(PRODUCT_VERSION_MAINTENANCE)-$(AQUARIOS_BUILD_TYPE)$(AQUARIOS_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    aquarios.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.aquarios.version=$(AQUARIOS_VERSION) \
    ro.modversion=$(AQUARIOS_MOD_VERSION) \
    ro.aquarios.buildtype=$(AQUARIOS_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/aquarios/tools/aquarios_process_props.py

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.device.cache_dir=/data/cache
else
  ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.device.cache_dir=/cache
endif

$(call prepend-product-if-exists, vendor/extra/product.mk)

# Proprietary latinime libs needed for Keyboard swyping
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif
