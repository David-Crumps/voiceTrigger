local mod = get_mod("voiceTrigger")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "keybinds",
				type = "group",
				sub_widgets = {
					{
						setting_id = "vacuum_capsule",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_vacuum_capsule",
					},
					{
						setting_id = "dog_hater",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_dog_hating"

					},
					{
						setting_id = "im_falling",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_im_falling",
					},
					{
						setting_id = "cryonic_rod",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_cryonic_rod", 
					},
					{
						setting_id = "no",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_no", 
					},
					{
						setting_id = "thank_you",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_thank_you", 
					},
					{
						setting_id = "battery",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_battery", 
					},
					{
						setting_id = "psyker_scream",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_psyker_scream", 
					}
				},
			},
		},
	},
}
