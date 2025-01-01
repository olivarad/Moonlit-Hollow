/// @description Generalized Spell Collision

if (other.id != caster_id)
{
	if (object_is_ancestor(other.id.object_index, obj_character) && (caster_id.prepared_spells[selected_spell_slot].target_bitmask & other.id.entity_type))
	{
		var _initial_health = other.id.current_health;
		var _final_health = other.id.current_health - floor(spell[? "effect_strength"] * random_range(0.8, 1));
		show_debug_message("Hit, HP before: " + string(_initial_health) + " after: " + string(_final_health));
	}
	instance_destroy(id);	
}