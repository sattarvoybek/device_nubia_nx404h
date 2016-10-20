add_lunch_combo cm_NX404H-userdebug
add_lunch_combo cm_NX404H-eng

add_lunch_combo mk_NX404H-userdebug
add_lunch_combo mk_NX404H-eng

sh device/NUBIA/NX404H/update-changelog.sh

rm -f out/target/product/NX404H/root/init.qcom.sdcard.rc
rm -rf out/target/product/NX404H/obj/ETC/init.qcom.sdcard.rc_intermediates
