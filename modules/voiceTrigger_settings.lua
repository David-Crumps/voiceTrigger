local VOQueryConstants = require("scripts/settings/dialogue/vo_query_constants")

local VOICE_SETTING = table.enum("cryonic_rod", "vacuum_capsule", "dog_hating", "no")

local voice_settings = {
    [VOICE_SETTING.cryonic_rod] = {
        voice_tag_concept = VOQueryConstants.concepts.on_demand_vo_tag_item,
        voice_tag_id = VOQueryConstants.trigger_ids.smart_tag_vo_pickup_control_rod,
    },
    [VOICE_SETTING.vacuum_capsule] = {
        voice_tag_concept = VOQueryConstants.concepts.on_demand_vo_tag_item,
        voice_tag_id = VOQueryConstants.trigger_ids.smart_tag_vo_pickup_container,
    },
    [VOICE_SETTING.no] = {
        voice_tag_concept = VOQueryConstants.concepts.on_demand_com_wheel,
        voice_tag_id = VOQueryConstants.trigger_ids.com_wheel_vo_no,
    }, 
    [VOICE_SETTING.dog_hating] = {}
}

return {
    VOICE_SETTING = VOICE_SETTING,
    voice_settings = voice_settings,
}



