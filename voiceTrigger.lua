local mod = get_mod("voiceTrigger")

local allowedArbitratorVoices = {
    adamant_male_c = true,
    adamant_female_c = true,    
}

local memoised_vo_settings = mod:persistent_table("memoised_vo_settings", {})

local comms_allowed = function()
    local game_mode = Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
    if
		not (game_mode and Managers.player) or not (game_mode == "coop_complete_objective") then
            return false
        end

    local player_unit = Managers.player:local_player_safe(1).player_unit
    return player_unit and ScriptUnit.has_extension(player_unit, "health_system"):is_alive()
end

mod.trigger_go_die = function()
    if not comms_allowed() then
        return
    end
    local player = Managers.player:local_player_safe(1)
    if allowedArbitratorVoices[player._profile.selected_voice] then
        mod:echo("haha")
    end

    local vo_settings_path = "dialogues/generated/gameplay_vo_adamant_male_c"
    local vo_settings = memoised_vo_settings[vo_settings_path]

    if not vo_settings then
        vo_settings = require(vo_settings_path)
        memoised_vo_settings[vo_settings_path] = vo_settings
    end
    
    local vo_sound_events = vo_settings.response_for_psyker_critical_health.sound_events    
    local vo_sound_from_pool = vo_sound_events[math.random(2)]
    local vo_file_path = "wwise/externals/" .. vo_sound_from_pool

    local world = Managers.world:world('level_world')
    local wwise_world = Managers.world:wwise_world(world)

    wwise_world:trigger_resource_external_event(
        "wwise/events/vo/play_sfx_es_player_vo_2d",
        "es_player_vo_2d",
        vo_file_path,
        4,
        wwise_world:make_auto_source(player.player_unit, 1)
    )
end

mod.trigger_vacuum_capsule = function()
    if not comms_allowed() then
        return
    end
    
    local player = Managers.player:local_player_safe(1)
    local vo_settings_path = "dialogues/generated/on_demand_vo_" .. player._profile.selected_voice
    local vo_settings = memoised_vo_settings[vo_settings_path]

    if not vo_settings then
        vo_settings = require(vo_settings_path)
        memoised_vo_settings[vo_settings_path] = vo_settings
    end
    
    local vo_sound_events = vo_settings.smart_tag_vo_pickup_container.sound_events    
    local vo_sound_from_pool = vo_sound_events[math.random(#vo_sound_events)]
    local vo_file_path = "wwise/externals/" .. vo_sound_from_pool

    local world = Managers.world:world('level_world')
    local wwise_world = Managers.world:wwise_world(world)

    wwise_world:trigger_resource_external_event(
        "wwise/events/vo/play_sfx_es_player_vo_2d",
        "es_player_vo_2d",
        vo_file_path,
        4,
        wwise_world:make_auto_source(player.player_unit, 1)
    )
end

-- local vo_settings_path = "dialogues/generated/on_demand_vo_" .. player._profile.selected_voice (pathing for vacuum capsule)

--adamant_male_c
--local vo_sound_look_at_ammo = vo_settings.response_for_psyker_critical_health.sound_events   
--1.) Die spare us all your whining 
--2.) So die, you are of little account
--other 2 are kak

