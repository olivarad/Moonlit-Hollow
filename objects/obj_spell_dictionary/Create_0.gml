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
sustainable: bool
sprite: asset
*/

spell_dictionary = ds_list_create();
ds_list_add(spell_dictionary, instance_create_layer(0, 0, "foreground", obj_defined_spell, {name: "firebolt", mana_cost : 20, target_type : TargetType.Enemy, cooldown_ticks : 10, duration_ticks : 60, primary_damage_type : DamageType.Fire, effect_strength : 12, movement_speed : 8, sprite : spr_player}));