/// @description Generalized Spell Collision

if (other.id != caster_id)
{
	if (object_is_ancestor(other.id.object_index, obj_character) && (caster_id.prepared_spells[selected_spell_slot].target_bitmask & other.id.entity_type))
	{
		var _damage = spell[? "effect_strength"];
		var _critical = false;
		if (resolve_damage_modifier(damage_type, other.id.immunity_bitmask))
		{
			_damage = 0;
		}
		else
		{
			if (resolve_damage_modifier(damage_type, other.id.resistance_bitmask))
			{
				_damage *= spell[? "resistance_multiplier"];
			}
			if (resolve_damage_modifier(damage_type, other.id.vulnerability_bitmask))
			{
				_damage *= 2;
			}
			else
			{
				_damage *= spell[? "not_vulnerable_multiplier"];
			}
			if (_damage > 0)
			{
				if (random(1) <= spell[? "critical_chance"])
				{
					_critical = true;
					_damage *= spell[? "critical_multiplier"];
				}
				_damage = floor(_damage * random_range(0.8, 1));
			}
		}
		var _initial_health = other.id.current_health;
		var _final_health = other.id.current_health - _damage;
		show_debug_message((_critical ? "Critical hit, Damage type " : "Hit, Damage type: ") + string(damage_type) + " HP before: " + string(_initial_health) + " after: " + string(_final_health));
	}
	instance_destroy(id);	
}