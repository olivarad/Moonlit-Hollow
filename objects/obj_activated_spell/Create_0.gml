/// @description 

var _move_x = caster_id.horizontal_look_ratio;
var _move_y = caster_id.vertical_look_ratio;
var _normalized_values = normalize(_move_x, _move_y);
move_x = spell[? "movement_speed"] * _normalized_values._x;
move_y = spell[? "movement_speed"] * _normalized_values._y;

id.sprite_index = spell[? "sprite"];

function spell_behavior()
{
	if (global.fixed_delta_timer.tick_count - initial_tick_count >= spell[? "duration_ticks"])
	{
		instance_destroy();	
	}
	var _move_x = move_x * global.fixed_delta_timer.delta;
	var _move_y = move_y * global.fixed_delta_timer.delta;
	move_and_collide(_move_x, _move_y, obj_collision);
}