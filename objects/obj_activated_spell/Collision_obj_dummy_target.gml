/// @description Collision (TODO: generalize)

if (variable_instance_exists(other.id, "current_health"))
{
	var _initial_health = other.id.current_health;
	var _final_health = other.id.current_health - spell[? "effect_strength"];
	show_debug_message("Hit, HP before: " + string(_initial_health) + " after: " + string(_final_health));
}
instance_destroy(id);