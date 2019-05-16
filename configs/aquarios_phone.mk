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

# Include common makefile
include vendor/aquarios/configs/common.mk

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.dun.override=0 \
    net.tethering.noprovisioning=true

# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# Sprint fuckery
CUSTOM_APNS_FILE := vendor/aquarios/prebuilt/etc/APNs/sprint.xml

# World SPN overrides list
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/etc/APNs/spn-conf.xml:system/etc/spn-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/aquarios/prebuilt/etc/APNs/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# TEMP: Force enable VoLTE/VoWiFi until it's able to be fixed properly
#PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   persist.dbg.ims_volte_enable=1 \
   persist.dbg.volte_avail_ovr=1 \
   persist.radio.calls.on.ims=1 \
   persist.radio.rat_on=combine
