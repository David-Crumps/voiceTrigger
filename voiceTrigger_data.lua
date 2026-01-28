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
						setting_id = "go_die",
						type = "keybind",
						default_value = {},
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "trigger_go_die"
					}

				},
			},
		},
	},
}
