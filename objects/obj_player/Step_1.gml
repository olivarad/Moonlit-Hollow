/// @description

event_inherited();

health_status_bar.status_percent = current_health / max_health;
mana_status_bar.status_percent = current_mana / max_mana;
if (last_required_percent_spell_index != selected_spell_index)
{
	last_required_percent_spell_slot = selected_spell_index;
	mana_status_bar.required_percent = global.spell_dictionary.get_spell_mana_cost(prepared_spells[selected_spell_index].spell_id) / max_mana;
}