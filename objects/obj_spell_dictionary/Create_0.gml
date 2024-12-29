/*
Spell Properties
name: string
mana_cost: int
target_type: TargetType
activation_ticks: int
cooldown_ticks: int
duration_ticks: int
primary_damage_type: DamageType
secondary_damage_type: DamageType or noone
effect_strength: int
movement_speed: int
can_trigger_remotely: bool
sprite: asset
*/

spell_dictionary = ds_map_create();

enum SpellIDs
{
	firebolt = 1,
	icicle = 2,
	spark = 4
}

add_spell_to_dictionary("firebolt", 20, TargetType.Enemy, 0, 10, 20, DamageType.Fire, noone, 12, 8, false, spr_spell_default);
add_spell_to_dictionary("icicle", 20, TargetType.Enemy, 0, 10, 20, DamageType.Ice, noone, 12, 8, false, spr_spell_default);
add_spell_to_dictionary("spark", 20, TargetType.Enemy, 0, 10, 20, DamageType.Lightning, noone, 12, 8, false, spr_spell_default);

function add_spell_to_dictionary(name, mana_cost, target_type, activation_ticks, cooldown_ticks, duration_ticks, primary_damage_type, secondary_damage_type, effect_strength, movement_speed, can_trigger_remotely, sprite)
{
	var _spell = ds_map_create();
	ds_map_add(_spell, "name", name);
	ds_map_add(_spell, "mana_cost", mana_cost);
	ds_map_add(_spell, "target_type", target_type);
	ds_map_add(_spell, "activation_ticks", activation_ticks);
	ds_map_add(_spell, "cooldown_ticks", cooldown_ticks);
	ds_map_add(_spell, "duration_ticks", duration_ticks);
	ds_map_add(_spell, "primary_damage_type", primary_damage_type);
	ds_map_add(_spell, "secondary_damage_type", secondary_damage_type);
	ds_map_add(_spell, "effect_strength", effect_strength);
	ds_map_add(_spell, "movement_speed", movement_speed);
	ds_map_add(_spell, "can_trigger_remotely", can_trigger_remotely);
	ds_map_add(_spell, "sprite", sprite);
	ds_map_add(spell_dictionary, next_spell_id, _spell);
	next_spell_id *= 2;
	for (var spell_id = 1; spell_id < next_spell_id; spell_id *= 2)
	{
		var _recovered_spell = ds_map_find_value(spell_dictionary, spell_id);
		show_debug_message("Name: " + _recovered_spell[? "name"]);
	}
	show_debug_message("");
}

function get_spell(spell_id)
{
	return ds_map_find_value(spell_dictionary, spell_id);
}