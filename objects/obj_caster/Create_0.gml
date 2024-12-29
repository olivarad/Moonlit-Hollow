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