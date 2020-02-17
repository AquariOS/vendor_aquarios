. "$(gettop)/vendor/extras/build/envsetup.sh"

aosp_devices=(
'blueline'
'bonito'
'coral'
'crosshatch'
'flame'
'marlin'
'taimen'
'walleye'
)

function lunch_devices() {
    add_lunch_combo aqua_${device}-user
    add_lunch_combo aqua_${device}-userdebug
}

for device in ${aosp_devices[@]}; do
    lunch_devices
done
