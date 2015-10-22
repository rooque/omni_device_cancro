#
# Copyright 2014 The Android Open Source Project
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
#

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

# Get the long list of APNs

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Show selinux status on settings
#PRODUCT_PROPERTY_OVERRIDES += \
#    ro.build.selinux=1

# Check SOC
PRODUCT_COPY_FILES += \
    device/xiaomi/cancro/checksoc.sh:checksoc.sh

PRODUCT_COPY_FILES += \
    device/xiaomi/cancro/etc/bl_lut.txt:system/etc/bl_lut.txt \
    device/xiaomi/cancro/etc/xtwifi.conf:system/etc/xtwifi.conf \
    device/xiaomi/cancro/etc/calib.cfg:system/etc/calib.cfg

# NFC
TARGET_USES_OS_NFC := true
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nfc.port=I2C

PRODUCT_PACKAGES += \
    nfc_nci.bcm2079x.default \
    NfcNci \
    Tag

ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/nfc/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/nfc/nfcee_access_debug.xml
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    device/xiaomi/cancro/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
    device/xiaomi/cancro/nfc/libnfc-brcm-20791b05.conf:system/etc/libnfc-brcm-20791b05.conf \
    device/xiaomi/cancro/nfc/firmware/bcm2079x-b5_firmware.ncd:system/vendor/firmware/bcm2079x-b5_firmware.ncd \
    device/xiaomi/cancro/nfc/firmware/bcm2079x-b5_pre_firmware.ncd:system/vendor/firmware/bcm2079x-b5_pre_firmware.ncd \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# Common QCOM configuration tools
$(call inherit-product, device/qcom/common/Android.mk)

DEVICE_PACKAGE_OVERLAYS += device/xiaomi/cancro/overlay

LOCAL_PATH := device/xiaomi/cancro

PRODUCT_CHARACTERISTICS := nosdcard

# USB
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp \
    camera2.portability.force_api=1

# CancroParts
PRODUCT_PACKAGES += \
    CancroParts

# Camera
PRODUCT_PACKAGES += \
    camera.msm8974

# Charger
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/root/chargeonlymode:root/sbin/chargeonlymode
    
#Recovery
PRODUCT_COPY_FILES += $(LOCAL_PATH)/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/root/wait4sensorhub.sh:system/bin/wait4sensorhub.sh


# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.rc \
    init.target.rc \
    init.qcom.usb.rc \
    ueventd.qcom.rc \
    init.class_main.sh \
    init.mdm.sh \
    init.qcom.class_core.sh \
    init.qcom.early_boot.sh \
    init.qcom.factory.sh \
    init.qcom.sh \
    init.qcom.ssr.sh \
    init.qcom.syspart_fixup.sh \
    init.qcom.usb.sh

# QCOM Config Script
PRODUCT_PACKAGES += \
    hsic.control.bt.sh \
    init.qcom.bt.sh \
    init.qcom.fm.sh \
    init.qcom.modem_links.sh \
    init.qcom.post_boot.sh \
    init.qcom.wifi.sh \
    qca6234-service.sh \
    usf_post_boot.sh


# GPS
PRODUCT_PACKAGES += \
    gps.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/gps/lowi.conf:system/etc/lowi.conf\
    $(LOCAL_PATH)/gps/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/gps/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/gps/quipc.conf:system/etc/quipc.conf \
    $(LOCAL_PATH)/gps/sap.conf:system/etc/sap.conf

PRODUCT_PROPERTY_OVERRIDES += \
    persist.gps.qc_nlp_in_use=1 \
    persist.loc.nlp_name=com.qualcomm.services.location \
    ro.gps.agps_provider=1 \
    ro.qc.sdk.izat.premium_enabled=1 \
    ro.qc.sdk.izat.service_mask=0x5

PRODUCT_PROPERTY_OVERRIDES += \
    persist.fuse_sdcard=true

# Lights
PRODUCT_PACKAGES += \
   lights.msm8974

# Power
PRODUCT_PACKAGES += \
    power.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/changepowermode.sh:system/bin/changepowermode.sh

PRODUCT_PROPERTY_OVERRIDES += \
    ro.qualcomm.perf.cores_online=2

# WiFi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv_x4.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_x4.bin \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv_x4lte.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_x4lte.bin \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv_x5.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_x5.bin \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv_x5gbl.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_x5gbl.bin

PRODUCT_PACKAGES += \
    dhcpcd.conf \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf \
    hostapd_default.conf \
    hostapd.accept \
    hostapd.deny
#   libwcnss_qmi

# SoftAP
PRODUCT_PACKAGES += \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    wcnss_service 


PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    wlan.driver.ath=0 \
    ro.use_data_netmgrd=true

# IPC router config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config


# Thermal config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermald-8974.conf:system/etc/thermald-8974.conf \
    $(LOCAL_PATH)/configs/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf \
    $(LOCAL_PATH)/configs/thermal-engine-perf.conf:system/etc/thermal-engine-perf.conf


# Proprietery Firmware
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/android_model_facea.dat:system/etc/android_model_facea.dat \
    $(LOCAL_PATH)/rootdir/etc/android_model_faceg.dat:system/etc/android_model_faceg.dat \
    $(LOCAL_PATH)/rootdir/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin:system/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin \
    $(LOCAL_PATH)/rootdir/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin.pca:system/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin.pca \
    $(LOCAL_PATH)/rootdir/etc/modem/Diag.cfg:system/etc/modem/Diag.cfg

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/init.qcom.audio.sh:system/etc/init.qcom.audio.sh \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/listen_platform_info.xml:system/etc/listen_platform_info.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_3_1.xml:system/etc/mixer_paths_3_1.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_3_1_forte.xml:system/etc/mixer_paths_3_1_forte.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_3_2.xml:system/etc/mixer_paths_3_2.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_3_2_forte.xml:system/etc/mixer_paths_3_2_forte.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_4_x.xml:system/etc/mixer_paths_4_x.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_4_x_forte.xml:system/etc/mixer_paths_4_x_forte.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_5_x.xml:system/etc/mixer_paths_5_x.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_5_x_forte.xml:system/etc/mixer_paths_5_x_forte.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_auxpcm_3_1.xml:system/etc/mixer_paths_auxpcm_3_1.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_auxpcm_3_2.xml:system/etc/mixer_paths_auxpcm_3_2.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_auxpcm_4_x.xml:system/etc/mixer_paths_auxpcm_4_x.xml \
    $(LOCAL_PATH)/audio/mixer_paths/mixer_paths_auxpcm_5_x.xml:system/etc/mixer_paths_auxpcm_5_x.xml \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X3/MTP_X3_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X3/MTP_X3_General_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X3/MTP_X3_Global_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X3/MTP_X3_Handset_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X3/MTP_X3_Hdmi_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X3/MTP_X3_Headset_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X3/MTP_X3_Speaker_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X4/MTP_X4_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X4/MTP_X4_General_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X4/MTP_X4_Global_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X4/MTP_X4_Handset_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X4/MTP_X4_Hdmi_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X4/MTP_X4_Headset_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X4/MTP_X4_Speaker_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X5/MTP_X5_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/X5/MTP_X5_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X5/MTP_X5_General_cal.acdb:system/etc/acdbdata/MTP/X5/MTP_X5_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X5/MTP_X5_Global_cal.acdb:system/etc/acdbdata/MTP/X5/MTP_X5_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X5/MTP_X5_Handset_cal.acdb:system/etc/acdbdata/MTP/X5/MTP_X5_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X5/MTP_X5_Hdmi_cal.acdb:system/etc/acdbdata/MTP/X5/MTP_X5_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X5/MTP_X5_Headset_cal.acdb:system/etc/acdbdata/MTP/X5/MTP_X5_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/X5/MTP_X5_Speaker_cal.acdb:system/etc/acdbdata/MTP/X5/MTP_X5_Speaker_cal.acdb




# Media profile
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    

# Media & Audio
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libdivxdrmdecrypt \
    libextmedia_jni \
    libdashplayer \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc \
    libOmxVidcCommon \
    libqcmediaplayer \
    libstagefrighthw \
    qcmediaplayer

PRODUCT_BOOT_JARS += qcmediaplayer

PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio_policy.msm8974 \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

PRODUCT_PROPERTY_OVERRIDES += \
    persist.speaker.prot.enable=true \
    qcom.hw.aac.encoder=false \
    tunnel.audio.encode=false \
    persist.audio.init_volume_index=1 \
    audio.offload.buffer.size.kb=32 \
    audio.offload.video=true \
    audio.offload.gapless.enabled=false \
    audio.offload.disable=1 \
    use.dedicated.device.for.voip=false \
    use.voice.path.for.pcm.voip=true \
    media.aac_51_output_enabled=true \
    ro.qc.sdk.audio.ssr=false \
    ro.qc.sdk.audio.fluencetype=fluence \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.voicerec=false \
    persist.audio.fluence.speaker=true \
    audio.offload.pcm.enable=false



#PRODUCT_PROPERTY_OVERRIDES += \
#    debug.qualcomm.sns.hal=w \
#    debug.qualcomm.sns.daemon=w \
#    debug.qualcomm.sns.libsensor1=w

# aDSP
#PRODUCT_PROPERTY_OVERRIDES += \
#    ro.qc.sdk.sensors.gestures=true

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs \
    mkntfs \
    dumpe2fs \
    resize2fs \
    e2fsck_static \
    mke2fs_static \
    resize2fs_static

PRODUCT_PACKAGES += \
    libxml2
    
# BoringSSL compatibility wrapper
PRODUCT_PACKAGES += \
    libboringssl-compat

# Graphics
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974 \
    liboverlay

# power down SIM card when modem is sent to Low Power Mode.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.apm_sim_not_pwdn=1

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8974
	
# IR package
PRODUCT_PACKAGES += \
    consumerir.msm8974

# Enable Adaptive Multi-Rate Wideband
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.enable.amr.wideband=1


# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Misc dependency packages
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    curl \
    libnl_2 \
    libbson

# ANT+
PRODUCT_PACKAGES += \
    AntHalService \
    com.dsi.ant.antradio_library \
    libantradio

#Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    qcom.bt.dev_power_class=1 \
    bluetooth.hfp.client=1 \
    ro.bluetooth.alwaysbleon=true 
    

ifneq ($(QCPATH),)
# proprietary wifi display, if available
PRODUCT_BOOT_JARS += WfdCommon
endif

# System properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nfc.port=I2C \
    persist.demo.hdmirotationlock=false \
    ro.hdmi.enable=true \
    debug.sf.hw=1 \
    debug.egl.hw=1 \
    persist.hwc.mdpcomp.enable=true \
    debug.mdpcomp.logs=0 \
    debug.composition.type=dyn \
    ro.sf.lcd_density=480 \
    dev.pm.dyn_samplingrate=1 \
    ro.opengles.version=196608 \
    ril.subscription.types=RUIM \
    persist.omh.enabled=true \
    persist.sys.ssr.restart_level=3 \
    persist.timed.enable=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    debug.mdpcomp.4k2kSplit=1

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.ltm_enable=true \
    assertdisplay.value=128 \
    persist.sys.gamut_mode=0

# avoid setting cdma sim to 2g
PRODUCT_PROPERTY_OVERRIDES += \
    ro.ril.multi_rat_capable=true

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/atmel-maxtouch.kl:system/usr/keylayout/atmel-maxtouch.kl \
    $(LOCAL_PATH)/keylayout/cyttsp_button.kl:system/usr/keylayout/cyttsp_button.kl \
    $(LOCAL_PATH)/keylayout/fts.kl:system/usr/keylayout/fts.kl \
    $(LOCAL_PATH)/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl:system/usr/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl \
    $(LOCAL_PATH)/keylayout/synaptics_dsx.kl:system/usr/keylayout/synaptics_dsx.kl \
    $(LOCAL_PATH)/keylayout/synaptics_rmi4_i2c.kl:system/usr/keylayout/synaptics_rmi4_i2c.kl

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.software.print.xml:system/etc/permissions/android.software.print.xml

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

ifneq ($(QCPATH),)
$(call inherit-product-if-exists, $(QCPATH)/prebuilt_HY11/target/product/msm8974/prebuilt.mk)
endif

$(call inherit-product, frameworks/native-caf/build/phone-xxhdpi-2048-dalvik-heap.mk)
$(call inherit-product, frameworks/native-caf/build/phone-xxhdpi-2048-hwui-memory.mk)

# call the proprietary setup
$(call inherit-product, vendor/xiaomi/cancro/cancro-vendor.mk)
