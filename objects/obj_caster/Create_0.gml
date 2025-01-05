/// @description
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
			global.spell_handler.activate(id, selected_spell_index, _spell, aim_assist());
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

/// @function		calculate_spell_targets();
/// @returns		Id.DsList possible targets from a spell's range
/// @description	find all targets in range of a spell
function calculate_spell_targets()
{
	var _possible_targets = ds_list_create();
	collision_circle_list(x, y, global.spell_dictionary.get_spell_range(prepared_spells[selected_spell_index].spell_id), obj_character, false, true, _possible_targets, false);
	return _possible_targets;
}

function aim_assist()
{
	var _possible_targets = calculate_spell_targets();
	var _best_candidate = {_id : noone, angle_difference : 360, distance : infinity};
	for (var _i = 0; _i < ds_list_size(_possible_targets); ++_i)
	{
		var _possible_target = ds_list_find_value(_possible_targets, _i);
		var _angle_difference = abs(angle_difference(point_direction(x, y, _possible_target.x, _possible_target.y), radtodeg(-look_angle)));
		var _no_sqrt_distance = sqr(x - _possible_target.x) + sqr(y - _possible_target.y);
		// new best candidate
		if (_angle_difference <= global.aim_assist_angle && _angle_difference < _best_candidate.angle_difference && ((_best_candidate.distance == infinity) || (_no_sqrt_distance < sqr(_best_candidate.distance))))
		{
			_best_candidate._id = _possible_target;
			_best_candidate.angle_difference = _angle_difference;
			_best_candidate.distance = sqrt(_no_sqrt_distance);
		}
	}
	ds_list_destroy(_possible_targets);
	return _best_candidate._id;
}