/// @description
spell_dictionary = ds_map_create();

enum SpellIDs
{
	firebolt = 1,
	icicle = 2,
	spark = 4,
	card_trick = 8
};

add_spell_to_dictionary("firebolt", 20, TargetModifier.Opposite, 0, 10, 20, [DamageType.Fire], 12, 1, 0.5, 0.125, 2.0, 8, false, 0, [spr_spell_default]);
add_spell_to_dictionary("icicle", 20, TargetModifier.Opposite, 0, 10, 20, [DamageType.Ice], 12, 1, 0.5, 0.125, 2.0, 8, false, 0, [spr_spell_default]);
add_spell_to_dictionary("spark", 20, TargetModifier.Opposite, 0, 10, 20, [DamageType.Lightning], 12, 1, 0.5, 0.125, 2.0, 8, false, 0, [spr_spell_default]);
add_spell_to_dictionary("card trick", 0, TargetModifier.NotSame, 0, 6, 10, global.non_heal_damage_types, 6, 0, 0, 1.0, 4.0, 12, false, 12, [spr_card_trick_ace, spr_card_trick_2, spr_card_trick_3, spr_card_trick_4, spr_card_trick_5, spr_card_trick_6, spr_card_trick_7, spr_card_trick_8, spr_card_trick_9, spr_card_trick_10, spr_card_trick_jack, spr_card_trick_queen, spr_card_trick_king]);

/// @function				add_spell_to_dictionary(name, mana_cost, target_modifier, activation_ticks, cooldown_ticks, duration_ticks, primary_damage_type, effect_strength, not_vulnerable_multiplier, resistance_multiplier, critical_chance, critical_multiplier, movement_speed, can_trigger_remotely, sprite);
/// @param {string}			name The spell's name
/// @param {real}			mana_cost The spell's cost in mana
/// @param					target_modifier The spell's TargetModifier enum value (set's affected EntityTypes)
/// @param {real}			activation_ticks The amount of ticks required to activate the spell
/// @param {real}			cooldown_ticks The amount of ticks allocated to the spell's cooldown
/// @param {real}			duration_ticks The amount of ticks the spell lasts for after casting (TODO: replace with a distance check for use with bots)
/// @param {array<real>}	damage_type_array The array for possible damages
/// @param {real}			effect_strength The strength of the activated effect
/// @param {real}			not_vulnerable_multiplier The multipler for damage when a creature is not velnerable to the spell
/// @param {real}			resistance_multiplier the multiplier for resisted damgage
/// @param {real}			critical_chance	decimal change of critical
/// @param {real}			critical_multiplier damage multipler for critical hits
/// @param {real}			movement_speed The speed at which the spell moves
/// @param {bool}			can_trigger_remotely Flag indicating if the spell can be triggered remotely
/// @param {real}			per_delta_rotation rotation of sprite per delta
/// @param {array}			sprite_pool The spell's possible random sprites
/// @description			add a spell to the spell dictionary.
function add_spell_to_dictionary(name, mana_cost, target_modifier, activation_ticks, cooldown_ticks, duration_ticks, damage_type_array, effect_strength, not_vulnerable_multiplier, resistance_multiplier, critical_chance, critical_multiplier, movement_speed, can_trigger_remotely, per_delta_rotation, sprite_pool)
{	
	var _spell = ds_map_create();
	ds_map_add(_spell, "name", name);
	ds_map_add(_spell, "mana_cost", mana_cost);
	ds_map_add(_spell, "target_modifier", target_modifier);
	ds_map_add(_spell, "activation_ticks", activation_ticks);
	ds_map_add(_spell, "cooldown_ticks", cooldown_ticks);
	ds_map_add(_spell, "duration_ticks", duration_ticks);
	ds_map_add(_spell, "effect_strength", effect_strength);
	ds_map_add(_spell, "not_vulnerable_multiplier", not_vulnerable_multiplier);
	ds_map_add(_spell, "resistance_multiplier", resistance_multiplier);
	ds_map_add(_spell, "critical_chance", critical_chance);
	ds_map_add(_spell, "critical_multiplier", critical_multiplier);
	ds_map_add(_spell, "movement_speed", movement_speed);
	ds_map_add(_spell, "can_trigger_remotely", can_trigger_remotely);
	ds_map_add(_spell, "per_delta_rotation", per_delta_rotation);
	ds_map_add(_spell, "sprite_pool", sprite_pool);
	if (array_length(damage_type_array) == 1) // damage type is not random, cannot relate to sprite
	{
		ds_map_add(_spell, "effective_damage_type", damage_type_array[0]);
		ds_map_add(_spell, "sprite_pool_index", irandom_range(0, array_length(sprite_pool) - 1));
	}
	else // damage type is random and MAY relate to sprite
	{
		ds_map_add(_spell, "damage_type_array", damage_type_array);
		if (array_length(damage_type_array) == array_length(sprite_pool)) // Damage type relates to sprite, use bag randomizer
		{
			var _damage_type_bag_randomizer = [];
			array_copy(_damage_type_bag_randomizer, 0, damage_type_array, 0, array_length(damage_type_array));
			var _sprite_pool_bag_randomizer = [];
			array_copy(_sprite_pool_bag_randomizer, 0, sprite_pool, 0, array_length(sprite_pool));
			ds_map_add(_spell, "damage_type_bag_randomizer", _damage_type_bag_randomizer);
			ds_map_add(_spell, "sprite_pool_bag_randomizer", _sprite_pool_bag_randomizer);
			ds_map_add(_spell, "effective_damage_type_and_sprite_index", irandom_range(0, array_length(damage_type_array) - 1));
		}
		else // Damage type and sprite are unrelated
		{
			ds_map_add(_spell, "effective_damage_type_index", irandom_range(0, array_length(damage_type_array) - 1));
			ds_map_add(_spell, "sprite_pool_index", irandom_range(0, array_length(sprite_pool) - 1))
		}
	}
	
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
	if (ds_map_exists(spell, "damage_type_array")) // damage type is random, MAY relate to sprite
	{
		if (ds_map_exists(spell, "effective_damage_type_and_sprite_index")) // Damage type relates to sprite
		{
			if (array_length(spell[? "damage_type_bag_randomizer"]) == 0)
			{
				var _damage_type_bag_randomizer = [];
				array_copy(_damage_type_bag_randomizer, 0, spell[? "damage_type_array"], 0, array_length(spell[? "damage_type_array"]));
				var _sprite_pool_bag_randomizer = [];
				array_copy(_sprite_pool_bag_randomizer, 0, spell[? "sprite_pool"], 0, array_length(spell[? "sprite_pool"]));
				ds_map_set(spell, "damage_type_bag_randomizer", _damage_type_bag_randomizer);
				ds_map_set(spell, "sprite_pool_bag_randomizer", _sprite_pool_bag_randomizer);
			}
			ds_map_set(spell, "effective_damage_type_and_sprite_index", irandom_range(0, array_length(spell[? "damage_type_bag_randomizer"]) - 1));
		}
		else // Damage type and sprite are unrelated
		{
			ds_map_set(spell, "effective_damage_type_index", irandom_range(0, array_length(spell[? "damage_type_array"]) - 1));
			ds_map_set(spell, "sprite_pool_index", irandom_range(0, array_length(spell[? "sprite_pool"]) - 1))
		}
	}
	else // damage type is constant, cannot relate to sprite
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

/// @function		get_spell_mana_cost(spell_id);
/// @param {real}	spell_id integer spell id
/// @returns {real}	spell mana cost
/// @descriptoin	obtain a spell's mana cost from the spell dictionary.
function get_spell_mana_cost(spell_id)
{
	var _spell = get_spell(spell_id);
	return _spell[? "mana_cost"];
}

/// @function					get_spell_sprite(spell_id);
/// @param {real}				spell_id integer spell id
/// @returns {asset.GMSprite}	current spell sprite
/// @description				obtain a spell's current sprite from the spell dictionary.
function get_spell_sprite(spell_id)
{
	var _spell = get_spell(spell_id);
	if (ds_map_exists(_spell, "effective_damage_type_and_sprite_index"))
	{
		var _sprite_pool_bar_randomizer = _spell[? "sprite_pool_bag_randomizer"];
		return _sprite_pool_bar_randomizer[_spell[? "effective_damage_type_and_sprite_index"]];
	}
	else
	{
		var _sprite_pool = _spell[? "sprite_pool"];
		return _sprite_pool[_spell[? "sprite_pool_index"]];	
	}
}