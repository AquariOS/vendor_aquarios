. "$(gettop)/vendor/extras/build/envsetup.sh"

aosp_devices=('blueline' 'bonito' 'crosshatch' 'marlin' 'coral')

function lunch_devices() {
    add_lunch_combo aqua_${device}-user
    add_lunch_combo aqua_${device}-userdebug
    add_lunch_combo aqua_${device}-eng}
}

for device in ${aosp_devices[@]}; do
    lunch_devices
done
