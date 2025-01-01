event_inherited();

/// @function		calculate_spell_target_types();
/// @description	calculate target types of all prepared spells, run every time prepared spells changes.
function calculate_spell_target_types()
{
	if (is_array(prepared_spells)) // Stop gamemaker from complaining about precreate expressions
	{
		for (var _i = 0; _i < max_prepared_spells; ++_i)
		{
			prepared_spells[_i].target_bitmask = resolve_target_type(entity_type, global.spell_dictionary.get_spell_target_modifier(prepared_spells[_i].spell_id));
			//show_debug_message("Spell: " + global.spell_dictionary.get_spell_name(prepared_spells[_i].spell_id) + ", Target Bitmask: " + string(prepared_spells[_i].target_bitmask));
		}
	}
}

/// @function		cast_attempt();
/// @description	cast a spell if the spell slot is ready and the caster has enough mana.
function cast_attempt()
{
	var _spell_slot_data = prepared_spells[selected_spell_index];
	if (_spell_slot_data.is_ready)
	{
		var _spell = global.spell_dictionary.get_spell(_spell_slot_data.spell_id);
		if (current_mana >= _spell[? "mana_cost"])
		{
			current_mana -= _spell[? "mana_cost"];
			prepared_spells[selected_spell_index].is_ready = false;
			global.spell_handler.activate(id, selected_spell_index, _spell)
		}
	}
}

/// @function		mana_regen();
/// @description	regenerate mana according the the caster's percent_mana_regen_per_second.
function mana_regen()
{
	if (current_mana != max_mana)
	{
		var _mana_increase = max_mana * (percent_mana_regen_per_second / 100) * ((tick_count - last_regen_tick) / global.ticks_per_second);
		if (current_mana + _mana_increase > max_mana)
		{
			current_mana = max_mana;	
		}
		else
		{
			current_mana += _mana_increase;
		}
	}
	last_regen_tick = tick_count;
}