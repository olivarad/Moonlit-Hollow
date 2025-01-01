/// @function				set_entity_type(object_id, entity_type);
/// @param {Id.Instance}	object_id The object of which entity_type is set
/// @param {real}			entity_type The entity type to set the object to
/// @description			Set entity type for provided object and handle all neccessary behaviors for entity type switch.
function set_entity_type(object_id, entity_type)
{
	if (!object_id || (entity_type & 7 == 0)) // no valid id or entitiy type
	{
		show_debug_message("set_entitiy_type: invalid usage");
		game_end(1);
	}
	else
	{
		object_id.entity_type = entity_type;
		if (object_is_ancestor(object_id.object_index, obj_caster))
		{
			object_id.calculate_spell_target_types();
		}
	}
}

/// @function		calculate_fixed_delta_move_speed();
/// @description	apply a fixed delta timing to movement speed.
function calculate_fixed_delta_move_speed()
{
	current_move_speed *= delta;
}

/// @function		health_regen();
/// @description	regenerate health according the the character's percent_health_regen_per_second
function health_regen()
{
	if (current_health != max_health)
	{
		var _health_increase = max_health * (percent_health_regen_per_second / 100) * ((tick_count - last_regen_tick) / global.ticks_per_second);
		if (current_health + _health_increase > max_health)
		{
			current_health = max_health;	
		}
		else
		{
			current_health += _health_increase;
		}
	}
}