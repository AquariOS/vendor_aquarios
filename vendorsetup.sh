. "$(gettop)/vendor/extras/build/envsetup.sh"

aosp_devices=('blueline' 'bonito' 'crosshatch' 'marlin' 'coral')
caf_devices=('oneplus3' 'enchilada' 'cheeseburger' 'dumpling' 'fajita')

function lunch_devices() {
    add_lunch_combo aqua_${device}-user
    add_lunch_combo aqua_${device}-userdebug
}

if [[ $( grep -i "caf" manifest/README.md) ]]; then
    for device in ${caf_devices[@]}; do
        lunch_devices
    done
else
    for device in ${aosp_devices[@]}; do
        lunch_devices
    done
fi
