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

# Inherit AOSP device configuration for bullhead
$(call inherit-product, device/lge/bullhead/aquarios.mk)

# Bullhead overides
ifneq ($(filter bullhead,$(PRODUCT_DEVICE)),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.carrier=unknown \
    ro.opa.eligible_device=true \
    ro.storage_manager.enabled=true \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true \
    ro.com.android.prov_mobiledata=false

endif

# Override AOSP build properties
PRODUCT_NAME := bullhead
PRODUCT_BRAND := google
PRODUCT_DEVICE := bullhead
PRODUCT_MODEL := Nexus 5X
PRODUCT_MANUFACTURER := LGE

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="bullhead-user 8.1.0 OPM6.171019.030.H1 4903069 release-keys"

BUILD_FINGERPRINT := google/bullhead/bullhead:8.1.0/OPM6.171019.030.H1/4903069:user/release-keys

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
