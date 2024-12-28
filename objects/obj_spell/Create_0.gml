/// @description 

function activate(caster_id, selected_spell_slot)
{
	if (activation_ticks != 0)
	{
		var _caster_activation_record = ds_map_create();
		_caster_activation_record.caster_id = caster_id;
		_caster_activation_record.selected_spell_slot = selected_spell_slot;
		_caster_activation_record.initial_tick_count = global.fixed_delta_timer.tick_count;
		ds_list_add(activation_timer, _caster_activation_record);
	}
	else
	{
		create_activated_instance(caster_id, selected_spell_slot);
	}
}

function check_timers()
{
	var _current_tick = global.fixed_delta_timer.tick_count;
	for (var _i = 0; _i < ds_list_size(activation_timer); ++_i)
	{
		var _caster_activation_record = activation_timer[_i];
		if (activation_ticks - (_current_tick - _caster_activation_record.initial_tick_count) <= 0)
		{
			create_activated_instance(_caster_activation_record.caster_id, _caster_activation_record.selected_spell_slot);
			ds_list_delete(activation_timer, _i);
			--_i;
		}
	}
	for (var _i = 0; _i < ds_list_size(cooldown_timer); ++_i)
	{
		var _caster_cooldown_record = cooldown_timer[_i];
		if (cooldown_ticks - (_current_tick - _caster_cooldown_record.initial_tick_count) <= 0)
		{
			// Set is_ready flag
			_caster_cooldown_record.caster_id.prepared_spells[_caster_cooldown_record.selected_spell_slot].is_ready = true;
			ds_list_delete(cooldown_timer, _i);
			--_i;
		}
	}
}

function create_activated_instance(caster_id, selected_spell_slot)
{
	var _caster_cooldown_record = ds_map_create();
	_caster_cooldown_record.caster_id = caster_id;
	_caster_cooldown_record.selected_spell_slot = selected_spell_slot;
	_caster_cooldown_record.initial_tick_count = global.fixed_delta_timer.tick_count;
	instance_create_layer(caster_id.x, caster_id.y, "foreground", obj_activated_spell, {caster_id : caster_id});
}