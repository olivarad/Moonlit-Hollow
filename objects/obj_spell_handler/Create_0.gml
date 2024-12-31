/// @description Spell handler for all caster objects

activation_timer = ds_list_create();
cooldown_timer = ds_list_create();
global.spell_dictionary = instance_create_layer(0, 0, "utility", obj_spell_dictionary);

/// @function				activate(caster_id, selected_spell_slot, spell);
/// @param {Id.Instance}	caster_id caster instance id
/// @param 					selected_spell_slot integer index of spell slot used to cast from caster's prepared_spells
/// @param {Id.DsMap<Any>}	spell a spell dictionary reference
/// @description			activates a spell or adds it's caster_activation_record to the activation timer
function activate(caster_id, selected_spell_slot, spell)
{
	if (spell[? "activation_ticks"] != 0)
	{
		var _caster_activation_record = ds_map_create();
		_caster_activation_record[? "caster_id"] = caster_id;
		_caster_activation_record[? "selected_spell_slot"] = selected_spell_slot;
		_caster_activation_record[? "spell"] = spell;
		_caster_activation_record[? "initial_tick_count"] = global.fixed_delta_timer.tick_count;
		ds_list_add(activation_timer, _caster_activation_record);
	}
	else
	{
		create_activated_instance(caster_id, selected_spell_slot, spell);
	}
}

/// @function				create_activated_instance(caster_id, selected_spell_slot, spell);
/// @param {Id.Instance}	caster_id caster instance id
/// @param					selected_spell_slot integer index of spell slot used to cast from caster's prepared_spells
/// @param {Id.DsMap<Any>}	spell a spell dictionary reference
/// @description			instances a spell and adds it's caster_caster_record to the cooldown timer or releases it's is_ready flag.
function create_activated_instance(caster_id, selected_spell_slot, spell)
{
	instance_create_layer(caster_id.x, caster_id.y, "foreground", obj_activated_spell, {caster_id : caster_id, spell : spell});
	if (spell[? "cooldown_ticks"] != 0)
	{
		var _caster_cooldown_record = ds_map_create();
		_caster_cooldown_record[? "caster_id"] = caster_id;
		_caster_cooldown_record[? "selected_spell_slot"] = selected_spell_slot;
		_caster_cooldown_record[? "cooldown_ticks"] = spell[? "cooldown_ticks"];
		_caster_cooldown_record[? "initial_tick_count"] = global.fixed_delta_timer.tick_count;
		ds_list_add(cooldown_timer, _caster_cooldown_record);
	}
	else
	{
		caster_id.prepared_spells[selected_spell_slot].is_ready = true;
	}
}

/// @function		check_timers();
/// @description	handles activation and cooldown timer.
function check_timers()
{
	// Activation timers
	var _current_tick = global.fixed_delta_timer.tick_count;
	for (var _i = 0; _i < ds_list_size(activation_timer); ++_i)
	{
		var _caster_activation_record = activation_timer[| _i];
		if (_caster_activation_record[? "spell"][? "activation_ticks"] - (_current_tick - _caster_activation_record[? "initial_tick_count"]) <= 0)
		{
			create_activated_instance(_caster_activation_record[? "caster_id"], _caster_activation_record[? "selected_spell_slot"], _caster_activation_record[? "spell"]);
			
			ds_map_destroy(_caster_activation_record);
			ds_list_delete(activation_timer, _i);
			--_i;
		}
	}
	// Cooldown timers
	for (var _i = 0; _i < ds_list_size(cooldown_timer); ++_i)
	{
		var _caster_cooldown_record = cooldown_timer[| _i];
		if (_caster_cooldown_record[? "cooldown_ticks"] - (_current_tick - _caster_cooldown_record[? "initial_tick_count"]) <= 0)
		{
			// Set is_ready flag
			var _caster = _caster_cooldown_record[? "caster_id"];
			var _selected_slot = _caster_cooldown_record[? "selected_spell_slot"];
			_caster.prepared_spells[_selected_slot].is_ready = true;
			
			ds_map_destroy(_caster_cooldown_record);
			ds_list_delete(cooldown_timer, _i);
			--_i;
		}
	}
}