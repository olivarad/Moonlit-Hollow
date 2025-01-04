/// @function		resolve_damage_modifier(damage_type, modifier_bitmask);
/// @param {real}	damage_type
/// @param {real}	modifier_bitmask
/// returns {bool}	true : applied, false : not applied
function resolve_damage_modifier(damage_type, modifier_bitmask)
{
	return (damage_type & modifier_bitmask) != 0;
}