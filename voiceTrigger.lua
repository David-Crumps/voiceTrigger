local mod = get_mod("voiceTrigger")

local VOQueryConstants = require("scripts/settings/dialogue/vo_query_constants")
local DialogueExtension = require("scripts/extension_systems/dialogue/dialogue_extension")
local Vo = require("scripts/utilities/vo")

local voice_trigger_module = mod:io_dofile("voiceTrigger/scripts/mods/voiceTrigger/modules/voiceTrigger_settings")

local VOICE_SETTING = voice_trigger_module.VOICE_SETTING
local voice_settings = voice_trigger_module.voice_settings

local HudElementSmartTagging_instance

local allowedHiveScumVoices = {
    broker_male_b = true,
}

local init_keybind_functions = function()
	local fun = function()
		return
	end
	for key in pairs(voice_settings) do
		    mod["trigger_" .. key] = fun
	end
end

local comms_allowed = function()
    local game_mode = Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
    if
		not (game_mode and Managers.player) or not (game_mode == "coop_complete_objective" or game_mode == "shooting_range") then
            return false
        end

    local player_unit = Managers.player:local_player_safe(1).player_unit
    return player_unit and ScriptUnit.has_extension(player_unit, "health_system"):is_alive()
end

local get_selected_voice = function()
    local player = Managers.player:local_player_safe(1)
    if player and player._profile then
        return player._profile.selected_voice
    end
end

local get_player_unit = function()
    local parent = HudElementSmartTagging_instance._parent
    local player_unit = parent:player_unit()

    return player_unit
end

mod.trigger_im_falling = function()
    if not comms_allowed() then
        return
    end
    local parent = HudElementSmartTagging_instance._parent
    local player_unit = parent:player_unit()

    if player_unit then
        Vo.player_catapulted_event(player_unit)
    end
end

mod.trigger_coughing_fit = function()
    if not comms_allowed() then
        return
    end
    local parent = HudElementSmartTagging_instance._parent
    local player_unit = parent:player_unit()

    if player_unit then
        Vo.coughing_event(player_unit)
    end
end

local hive_scum_dog_hating = function()
    local voice = get_selected_voice()
    if allowedHiveScumVoices[voice] then
        local player_unit = get_player_unit()
        if player_unit then
            Vo.player_pounced_by_special_event(player_unit, "chaos_hound")
        end
    end
end

local setup_keybinds = function()
    for key, setting in pairs(voice_settings) do
        if key == "dog_hating" then
            mod["trigger_" .. key] = function()
                if not comms_allowed() then
                    return
                end
                hive_scum_dog_hating()
            end
        else
            mod["trigger_" .. key] = function()
                if not comms_allowed() then
                    return
                end
                local voice_tag_concept = setting.voice_tag_concept
                local voice_tag_id = setting.voice_tag_id

                if voice_tag_concept and voice_tag_id then
                    local player_unit = get_player_unit()
                    
                    if player_unit then
                        Vo.on_demand_vo_event(
                            player_unit,
                            voice_tag_concept,
                            voice_tag_id
                        )
                    end
                end
            end
        end              
    end
end

mod:hook_safe("HudElementSmartTagging", "update", function(self, dt, t, ui_renderer, render_settings, input_service)
    if not HudElementSmartTagging_instance then
        HudElementSmartTagging_instance = self
        setup_keybinds()
    end
end)

mod.on_unload = function()
    HudElementSmartTagging_instance = nil
end

--Vo.player_ledge_hanging_event(player_unit)
--Vo.play_combat_ability_event(player_unit, "ability_buff_stance") -> scriers
--Vo.play_combat_ability_event(player_unit, "ability_biomancer_high")

init_keybind_functions()