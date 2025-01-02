/// @description
spell_dictionary = ds_map_create();

enum SpellIDs
{
	firebolt = 1,
	icicle = 2,
	spark = 4,
	card_trick = 8
};

add_spell_to_dictionary("firebolt", 20, TargetModifier.Opposite, 0, 10, 20, DamageType.Fire, noone, 12, 8, false, [spr_spell_default]);
add_spell_to_dictionary("icicle", 20, TargetModifier.Opposite, 0, 10, 20, DamageType.Ice, noone, 12, 8, false, [spr_spell_default]);
add_spell_to_dictionary("spark", 20, TargetModifier.Opposite, 0, 10, 20, DamageType.Lightning, noone, 12, 8, false, [spr_spell_default]);
add_spell_to_dictionary("card trick", 0, TargetModifier.NotSame, 0, 60, 10, DamageType.Random, noone, 2, 12, false, [spr_spell_default, spr_player]);

/// @function		add_spell_to_dictionary(name, mana_cost, target_modifier, activation_ticks, cooldown_ticks, duration_ticks, primary_damage_type, secondary_damage_type, effect_strength, movement_speed, can_trigger_remotely, sprite);
/// @param {string}	name The spell's name
/// @param {real}	mana_cost The spell's cost in mana
/// @param			target_modifier The spell's TargetModifier enum value (set's affected EntityTypes)
/// @param {real}	activation_ticks The amount of ticks required to activate the spell
/// @param {real}	cooldown_ticks The amount of ticks allocated to the spell's cooldown
/// @param {real}	duration_ticks The amount of ticks the spell lasts for after casting (TODO: replace with a distance check for use with bots)
/// @param			primary_damage_type The primary damage type of the spell
/// @param			secondary_damage_type The secondary damage type of the spell (noone valid)
/// @param {real}	effect_strength The strength of the activated effect
/// @param {real}	movement_speed The speed at which the spell moves
/// @param {bool}	can_trigger_remotely Flag indicating if the spell can be triggered remotely
/// @param {array}	sprite_pool The spell's possible random sprites
/// @description	add a spell to the spell dictionary.
function add_spell_to_dictionary(name, mana_cost, target_modifier, activation_ticks, cooldown_ticks, duration_ticks, primary_damage_type, secondary_damage_type, effect_strength, movement_speed, can_trigger_remotely, sprite_pool)
{	
	var _spell = ds_map_create();
	ds_map_add(_spell, "name", name);
	ds_map_add(_spell, "mana_cost", mana_cost);
	ds_map_add(_spell, "target_modifier", target_modifier);
	ds_map_add(_spell, "activation_ticks", activation_ticks);
	ds_map_add(_spell, "cooldown_ticks", cooldown_ticks);
	ds_map_add(_spell, "duration_ticks", duration_ticks);
	ds_map_add(_spell, "effect_strength", effect_strength);
	ds_map_add(_spell, "movement_speed", movement_speed);
	ds_map_add(_spell, "can_trigger_remotely", can_trigger_remotely);
	ds_map_add(_spell, "sprite_pool", sprite_pool);
	ds_map_add(_spell, "primary_damage_type", primary_damage_type);
	if (_spell[? "primary_damage_type"] == DamageType.Random)
	{
		if (array_length(_spell[? "sprite_pool"]) = 13) // sprite indicates damage type
		{
			// Only Neutral and heal are excluded
			
			ds_map_add(_spell, "sprite_pool_index", irandom_range(0, 12));
			ds_map_add(_spell, "effective_primary_damage_type", power(2, _spell[? "sprite_pool_index"] + 1));
		}
		else // sprite and damage type are unrelated
		{
			ds_map_add(_spell, "sprite_pool_index", irandom_range(0, array_length(sprite_pool) - 1));
			ds_map_add(_spell, "effective_primary_damage_type", power(2, irandom_range(1, 13)));
		}
	}
	else
	{
		ds_map_add(_spell, "sprite_pool_index", irandom_range(0, array_length(sprite_pool) - 1));
		ds_map_add(_spell, "effective_primary_damage_type", primary_damage_type);
	}	
	ds_map_add(_spell, "secondary_damage_type", secondary_damage_type);
	
	ds_map_add(spell_dictionary, next_spell_id, _spell);
	next_spell_id *= 2;
	for (var spell_id = 1; spell_id < next_spell_id; spell_id *= 2)
	{
		var _recovered_spell = ds_map_find_value(spell_dictionary, spell_id);
		show_debug_message("Name: " + _recovered_spell[? "name"]);
	}
	show_debug_message("");
}

/// @function					get_spell(spell_id);
/// @param {real}				spell_id integer spell id
/// @returns {Id.DsMap<Any>}	Reference to spell dictionary table
/// @description				Obtains a spell reference, specified with spell_id, from the spell dictionary.
function get_spell(spell_id)
{
	return ds_map_find_value(spell_dictionary, spell_id);
}

/// @function		randomize_spell_sprite_and_primary_damage_type(spell)
/// @param			{ID.DsMap<Any>} spell
/// @description	randomize a spell's sprite and primary_damage_type (internal use only)
function randomize_spell_sprite_and_primary_damage_type(spell)
{
	if (spell[? "primary_damage_type"] == DamageType.Random)
	{
		if (array_length(spell[? "sprite_pool"]) = 13) // sprite indicates damage type
		{
			// Only Neutral and heal are excluded
			
			ds_map_set(spell, "sprite_pool_index", irandom_range(0, 12));
			ds_map_set(spell, "effective_primary_damage_type", power(2, spell[? "sprite_pool_index"] + 1));
		}
		else // sprite and damage type are unrelated
		{
			ds_map_set(spell, "sprite_pool_index", irandom_range(0, array_length(spell[? "sprite_pool"]) - 1));
			ds_map_set(spell, "effective_primary_damage_type", power(2, irandom_range(1, 13)));
		}
	}
	else
	{
		ds_map_set(spell, "sprite_pool_index", irandom_range(0, array_length(spell[? "sprite_pool"]) - 1));
	}	
}

/// @function			get_spell_name(spell_id);
/// @param {real}		spell_id integer spell id
/// @returns {string}	spell name
/// @description		Obtains a spell's name from the spell dictionary.
function get_spell_name(spell_id)
{
	var _spell = get_spell(spell_id);
	return _spell[? "name"];
}

/// @function		get_spell_target_modifier(spell_id);
/// @param {real}	spell_id integer spell id
/// @returns {real}	spell targer modifier
/// @description	Obtains a spell's target modifer from the spell dictionary.
function get_spell_target_modifier(spell_id)
{
	var _spell = get_spell(spell_id);
	return _spell[? "target_modifier"];
}

function get_spell_mana_cost(spell_id)
{
	var _spell = get_spell(spell_id);
	return _spell[? "mana_cost"];
}