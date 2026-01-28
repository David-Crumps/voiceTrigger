local mod = get_mod("voiceTrigger")

local VOQueryConstants = require("scripts/settings/dialogue/vo_query_constants")
local DialogueExtension = require("scripts/extension_systems/dialogue/dialogue_extension")
local Vo = require("scripts/utilities/vo")

local HudElementSmartTagging_instance

local allowedArbitratorVoices = {
    adamant_male_c = true,
    adamant_female_c = true,    
}

local allowedHiveScumVoices = {
    broker_male_b = true,
}

local COOLDOWN = 5

local memoised_vo_settings = mod:persistent_table("memoised_vo_settings", {})


local comms_allowed = function()
    local game_mode = Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
    if
		not (game_mode and Managers.player) or not (game_mode == "coop_complete_objective" or game_mode == "shooting_range") then
            return false
        end

    local player_unit = Managers.player:local_player_safe(1).player_unit
    return player_unit and ScriptUnit.has_extension(player_unit, "health_system"):is_alive()
end


local cooldown = function()
    if mod.last_voice_trigger and os.clock() - mod.last_voice_trigger < COOLDOWN then
        return false
    end
    mod.last_voice_trigger = os.clock()
    return true
end


local get_selected_voice = function(player)
    if player and player._profile then
        return player._profile.selected_voice
    end
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

mod.trigger_dog_hating = function() 
    if not comms_allowed() then
        return
    end
    local player = Managers.player:local_player_safe(1)
    local voice = get_selected_voice(player)

    if allowedHiveScumVoices[voice] then
        local parent = HudElementSmartTagging_instance._parent
        local player_unit = parent:player_unit()
    
        if player_unit then
            Vo.player_pounced_by_special_event(player_unit, "chaos_hound")
        end
    end
end

mod.trigger_vacuum_capsule = function()
    if not comms_allowed() then
        return
    end

    local parent = HudElementSmartTagging_instance._parent
    local player_unit = parent:player_unit()
    
    local voice_tag_concept = VOQueryConstants.concepts.on_demand_vo_tag_item
    local voice_tag_id = VOQueryConstants.trigger_ids.smart_tag_vo_pickup_container

    if player_unit then
        Vo.on_demand_vo_event(
            player_unit,
            voice_tag_concept,
            voice_tag_id
        )
    end
end

mod:hook_safe("HudElementSmartTagging", "update", function(self, dt, t, ui_renderer, render_settings, input_service)
    if not HudElementSmartTagging_instance then
        HudElementSmartTagging_instance = self
    end
end)

mod.on_unload = function()
    HudElementSmartTagging_instance = nil
end


--Vo.player_ledge_hanging_event(player_unit)
--Vo.play_combat_ability_event(player_unit, "ability_buff_stance") -> scriers
--Vo.play_combat_ability_event(player_unit, "ability_biomancer_high")