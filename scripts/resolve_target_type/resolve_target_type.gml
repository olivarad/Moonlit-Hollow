/// @function		resolve_target_type(my_type, target_modifier);
/// @param {real}	my_type EntityType of character object
///	@param {real}	target_modifier TargetModifier to be compared against
/// @returns {real}	bitmask for effect comparison
/// @description	creates a bitmask for comparing against different EntityTypes and TargetModifiers.
function resolve_target_type(my_type, target_modifier)
{
	switch(target_modifier)
	{
		case TargetModifier.Mine:
			return my_type;
		case TargetModifier.NotMine:
			return 7 ^ my_type; // 7 = 111 or Enemy Neutral Friendly
		case TargetModifier.Opposite:
			if (my_type == EntityType.Neutral)
			{
				return 0;
			}
			else
			{
				return 5 ^ my_type; // 5 = 101 or Ememy Friendly
			}
		default:
			show_debug_message("resolve_target_type: invalid usage")
			game_end(1);
	}
}