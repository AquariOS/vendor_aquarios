# Copyright (C) 2018 AquariOS
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

# Include custom telephony configuration
include vendor/aquarios/configs/aquarios_phone.mk

# Inherit from those products. Most specific first.
$(call inherit-product, device/google/crosshatch/aquarios.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

PRODUCT_NAME := crosshatch
PRODUCT_DEVICE := crosshatch
PRODUCT_BRAND := Google
PRODUCT_MODEL := Pixel 3 XL
PRODUCT_MANUFACTURER := Google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=crosshatch \
    PRIVATE_BUILD_DESC="crosshatch-user 9 PQ2A.190305.002 5240760 release-keys"

BUILD_FINGERPRINT := google/crosshatch/crosshatch:9/PQ2A.190305.002/5240760:user/release-keys

