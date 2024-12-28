/// @description 

function cast_attempt()
{
	var _spell_slot_data = prepared_spells[selected_spell_index];
	if (_spell_slot_data.spell_id && _spell_slot_data.is_ready && mana >= _spell_slot_data.spell_id.mana_cost)
	{
		mana -= _spell_slot_data.spell_id.mana_cost;
		_spell_slot_data.is_ready = false;
		_spell_slot_data.spell_id.activate(caster_id);
	}
}