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

# AquariOS build type
BUILD_DATE := $(shell date +%m.%d.%Y)
BUILD_TIME := $(shell date +%H%M)

ifndef AQUARIOS_BUILD_TYPE
    AQUARIOS_BUILD_TYPE := UNOFFICIAL
endif

TARGET_PRODUCT_SHORT := $(subst aqua_,,$(AQUARIOS_BUILD_TYPE))

# AquariOS build naming
AQUARIOS_VERSION := $(PLATFORM_VERSION)_$(AQUARIOS_BUILD_TYPE)_$(BUILD_DATE)-$(BUILD_TIME)
AQUA_BUILD := true 
ROM_FINGERPRINT := AquariOS/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

# AquariOS build properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.aquarios.version=$(AQUARIOS_VERSION) \
    ro.aqua.version=X \
    ro.aquarios.type=$(AQUARIOS_BUILD_TYPE) \
    ro.aqua.fingerprint=$(ROM_FINGERPRINT)

# SystemUI Tests
EXCLUDE_SYSTEMUI_TESTS := true

# Use ccache with builds
USE_CCACHE := true

# Try ThinLTO cache
USE_THINLTO_CACHE=true
