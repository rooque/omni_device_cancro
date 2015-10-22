# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#
# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)
# Get the prebuilt list of APNs
$(call inherit-product, vendor/omni/config/gsm.mk)
# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)
# must be before including omni part
TARGET_BOOTANIMATION_SIZE := 720x480
# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)
# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/xiaomi/cancro/device.mk)
# Discard inherited values and use our own instead.

PRODUCT_NAME := omni_cancro
PRODUCT_DEVICE := cancro
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := Xiaomi
#PRODUCT_MODEL := MI 4

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Device prop
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE="cancro" \
    PRODUCT_NAME="cancro" 
    
# no DSPManager for us
TARGET_NO_DSPMANAGER := true

PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT="xiaomi/cancro/cancro:6.0/MRA58N/5.11.1:user/release-keys" \
    PRIVATE_BUILD_DESC="cancro-user 6.0 MRA58N 5.11.1 release-keys"

#TARGET_CONTINUOUS_SPLASH_ENABLED := true

# Inline kernel
TARGET_KERNEL_SOURCE := kernel/xiaomi/cancro
TARGET_KERNEL_CONFIG := omni_cancro_defconfig

