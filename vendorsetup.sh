add_lunch_combo cm_NX404H-userdebug
add_lunch_combo cm_NX404H-eng

add_lunch_combo mk_NX404H-userdebug
add_lunch_combo mk_NX404H-eng

sh device/NUBIA/NX404H/update-changelog.sh

cd frameworks/base
if grep -q "ro.storage_list.override" services/core/java/com/android/server/MountService.java
then
    echo '[storages] Frameworks/base already patched';
else
    git am ../../device/NUBIA/NX404H/patches/frameworks-base-1.patch || git am --abort
    git am ../../device/NUBIA/NX404H/patches/frameworks-base-2.patch || git am --abort
fi
if grep -q "SHOW_SU_INDICATOR" core/java/android/provider/Settings.java
then
    echo '[su icon] Frameworks/base already patched';
else
    git am ../../device/NUBIA/NX404H/patches/su-icon-frameworks-base.patch || git am --abort
fi
if [ -e "core/res/res/values/bliss_strings.xml" ]; then
    if grep -qs "statusbar_powerkey v01" packages/SystemUI/src/com/atx/siyang/PowerKey.java
    then
        echo '[statusbar powerkey] Frameworks/base already patched';
    else
        git am ../../device/NUBIA/NX404H/patches/statusbar-powerkey-frameworks-base-bliss.patch || git am --abort
    fi
else
    if grep -qs "statusbar_powerkey v01" packages/SystemUI/src/com/atx/siyang/PowerKey.java
    then
        echo '[statusbar powerkey] Frameworks/base already patched';
    else
        git am ../../device/NUBIA/NX404H/patches/statusbar-powerkey-frameworks-base.patch || git am --abort
    fi
fi
if grep -q "mShowExclamationMarks" packages/SystemUI/src/com/android/systemui/statusbar/policy/MSimNetworkControllerImpl.java
then
    echo '[signal icons] Frameworks/base already patched';
else
    git am ../../device/NUBIA/NX404H/patches/signal-without-exclamation-mark-frameworks-base.patch || git am --abort
fi
croot

cd packages/apps/Settings
if grep -q "show_su_indicator" res/xml/status_bar_settings.xml
then
    echo '[su icon] Settings already patched';
else
    git am --ignore-whitespace ../../../device/NUBIA/NX404H/patches/su-icon-settings.patch || git am --abort
fi
   if grep -q "statusbar_powerkey v01" res/xml/status_bar_settings.xml
    then
        echo '[statusbar powerkey] Settings already patched';
    else
        git am --ignore-whitespace ../../../device/NUBIA/NX404H/patches/statusbar-powerkey-settings.patch || git am --abort
    fi

fi
croot

#cd hardware/qcom/media-caf/msm8974
#if grep -q "QCOM_MEDIA_DISABLE_BUFFER_SIZE_CHECK" mm-video-v4l2/vidc/vdec/src/omx_vdec_msm8974.cpp
#then
#    echo '[buffer check] Media-caf mm-video-v4l2 already patched';
#else
#    git am ../../../../device/NUBIA/NX404H/patches/media-disable-buffer-check.patch || git am --abort
#fi
croot

cd packages/apps/Contacts
if grep -q "WRITE_MEDIA_STORAGE" AndroidManifest.xml
then
    echo '[vcards export] Contacts already patched';
else
    git am ../../../device/NUBIA/NX404H/patches/export-vcards-contacts.patch || git am --abort
fi
croot


rm -f out/target/product/NX404H/root/init.qcom.sdcard.rc
rm -rf out/target/product/NX404H/obj/ETC/init.qcom.sdcard.rc_intermediates
