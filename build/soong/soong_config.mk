add_json_val_default = $(call add_json_val, $(1), $(if $(strip $(2)), $(2), $(3)))

_contents := $(_contents)    "Aquarios":{$(newline)

# See build/core/soong_config.mk for the add_json_* functions you can use here.
$(call add_json_val_default, Bootloader_message_offset, $(BOOTLOADER_MESSAGE_OFFSET), 0)
$(call add_json_bool, Recovery_skip_ev_rel_input, $(filter true,$(TARGET_RECOVERY_SKIP_EV_REL_INPUT)))

# This causes the build system to strip out the last comma in our nested struct, to keep the JSON valid.
_contents := $(_contents)__SV_END

_contents := $(_contents)    },$(newline)
