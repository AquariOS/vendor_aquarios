PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/aquarios/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aquarios/prebuilt/common/bin/50-aquarios.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-aquarios.sh \
    vendor/aquarios/prebuilt/common/bin/clean_cache.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/clean_cache.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/aquarios/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/aquarios/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/aquarios/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# Aquarios-specific init file
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/init.local.rc:root/init.aquarios.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/lib/libjni_latinimegoogle.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libjni_latinimegoogle.so

# SELinux file system labels
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/init.d/50selinuxrelabel:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Fix Dialer
#PRODUCT_COPY_FILES +=  \
#    vendor/aquarios/prebuilt/common/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml

# privapp permissions
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/permissions/privapp-permissions-gzr.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-gzr.xml \
    vendor/aquarios/prebuilt/common/etc/permissions/privapp-permissions-google.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/aquarios/config/permissions/aquarios-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/aquarios-power-whitelist.xml

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    LockClock \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Extra Optional packages
PRODUCT_PACKAGES += \
    Calculator \
    LatinIME \
    BluetoothExt \
    Launcher3Dark

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Common overlay
DEVICE_PACKAGE_OVERLAYS += vendor/aquarios/overlay/common

# Show hardware keys category for supported devices only
ifneq ($(filter dumpling cheeseburger oneplus3,$(TARGET_DEVICE)),)
DEVICE_PACKAGE_OVERLAYS += vendor/aquarios/overlay/device
endif

# Versioning System
# aquarios first version.
PRODUCT_VERSION_MAJOR = X
PRODUCT_VERSION_MINOR = Stable
PRODUCT_VERSION_MAINTENANCE = 2.0
AQUARIOS_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
ifdef AQUARIOS_BUILD_EXTRA
    AQUARIOS_POSTFIX := -$(AQUARIOS_BUILD_EXTRA)
endif

ifndef AQUARIOS_BUILD_TYPE
    AQUARIOS_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
AQUARIOS_VERSION := AquariOS-$(AQUARIOS_BUILD)-$(PRODUCT_VERSION_MAJOR)-$(AQUARIOS_BUILD_TYPE)$(AQUARIOS_POSTFIX)
AQUARIOS_MOD_VERSION := AquariOS-$(AQUARIOS_BUILD)-$(PRODUCT_VERSION_MAJOR)-$(AQUARIOS_BUILD_TYPE)$(AQUARIOS_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    aquarios.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.aquarios.version=$(AQUARIOS_VERSION) \
    ro.modversion=$(AQUARIOS_MOD_VERSION) \
    ro.aquarios.buildtype=$(AQUARIOS_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/aquarios/tools/aquarios_process_props.py

# Vendor/themes
$(call inherit-product, vendor/assets/common.mk)
