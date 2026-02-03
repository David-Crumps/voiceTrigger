local mod = get_mod("voiceTrigger")

return {
	name = "voiceTrigger",
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
						setting_id = "coughing_fit",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_coughing_fit"
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
					}
				},
			},
		},
	},
}
