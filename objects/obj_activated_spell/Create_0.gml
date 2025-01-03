/// @description 
final_tick_count = global.fixed_delta_timer.tick_count + spell[? "duration_ticks"];
var _sprite_pool = spell[? "sprite_pool"];
if (ds_map_exists(spell, "effective_damage_type")) // damage type and sprite are unrelated
{
	damage_type = spell[? "effective_damage_type"];
	var _sprite_pool_index = spell[? "sprite_pool_index"];
	sprite_index = _sprite_pool[_sprite_pool_index];
}
else // damage type and sprite MAY be related
{
	if (ds_map_exists(spell, "effective_damage_type_and_sprite_index")) // damage type and sprite are related
	{
		var _damage_type_bag_randomizer = spell[? "damage_type_bag_randomizer"];
		var _sprite_pool_bag_randomizer = spell[? "sprite_pool_bag_randomizer"];
		var _effective_damage_type_and_sprite_index = spell[? "effective_damage_type_and_sprite_index"];
		damage_type = _damage_type_bag_randomizer[_effective_damage_type_and_sprite_index];
		sprite_index = _sprite_pool_bag_randomizer[_effective_damage_type_and_sprite_index];
		array_delete(_damage_type_bag_randomizer, _effective_damage_type_and_sprite_index, 1);
		array_delete(_sprite_pool_bag_randomizer, _effective_damage_type_and_sprite_index, 1);
	}
	else // damage type and sprite are unrelated
	{
		var _damage_type_array = spell[? "damage_type_array"];
		damage_type = _damage_type_array[spell[? "effective_damage_type_index"]];
		sprite_index = _sprite_pool[spell[? "sprite_pool_index"]];
	}
}
var _move_x = caster_id.horizontal_look_ratio;
var _move_y = caster_id.vertical_look_ratio;
var _normalized_values = normalize(_move_x, _move_y);
move_x = spell[? "movement_speed"] * _normalized_values._x;
move_y = spell[? "movement_speed"] * _normalized_values._y;
var _sprite_pool_index = spell[? "sprite_pool_index"];
image_angle = arctan2(_normalized_values._y, _normalized_values._x);
global.spell_dictionary.randomize_spell_sprite_and_primary_damage_type(spell);

/// @function		spell_behavior();
/// @description	preform spell behavoir as defined in a spell's dictionary table.
function spell_behavior()
{
	if (global.fixed_delta_timer.tick_count >= final_tick_count)
	{
		instance_destroy();	
	}
	//var _move_x = move_x * global.fixed_delta_timer.delta;
	//var _move_y = move_y * global.fixed_delta_timer.delta;
	//move_and_collide(_move_x, _move_y, obj_collision);
	x += move_x * global.fixed_delta_timer.delta;
	y += move_y * global.fixed_delta_timer.delta;
}