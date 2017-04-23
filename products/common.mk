# Copyright (C) 2017 AquariOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Include overlays
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/aquarios/overlay/common

# Main Required Packages
PRODUCT_PACKAGES += \
    Launcher3 \
    LiveWallpapersPicker \
    OmniJaws \
    OmniStyle \
    WallpaperPickerGooglePrebuilt

# Copy Magisk zip
# PRODUCT_COPY_FILES += \
#    vendor/aquarios/prebuilt/zip/magisk.zip:system/addon.d/magisk.zip

# Boot animations
$(call inherit-product-if-exists, vendor/aquarios/products/bootanimation.mk)

# APN
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Init file
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/init.local.rc:root/init.aqua.rc

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Init.d script support
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/bin/sysinit:system/bin/sysinit \
    vendor/aquarios/prebuilt/init.d/init.d.rc:root/init.d.rc

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/aquarios/prebuilt/addon.d/50-aquarios.sh:system/addon.d/50-aquarios.sh \
    vendor/aquarios/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/aquarios/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh 

# Disable Rescue Party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

# Set custom volume steps
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.media_vol_steps=30
    ro.config.media_vol_steps=30 \
    ro.config.bt_sco_vol_steps=30

# Prebuilt busybox fstrim command
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/bin/fstrim:system/bin/fstrim

# AquariOS versioning
ifndef AQUARIOS_BUILD_TYPE
    AQUARIOS_BUILD_TYPE := UNOFFICIAL
endif

AQUARIOS_VERSION := $(PLATFORM_VERSION)-$(AQUARIOS_BUILD_TYPE)-$(shell date +%Y%m%d-%H%M)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.aquarios.version=$(AQUARIOS_VERSION)

# DU Utils Library
PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

# Latin IME lib - gesture typing
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/etc/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Clean up packages cache to avoid wrong strings and resources
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/bin/clean_cache.sh:system/bin/clean_cache.sh

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni
