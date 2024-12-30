/// @description 

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