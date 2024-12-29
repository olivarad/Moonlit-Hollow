event_inherited();

function calculate_current_move_speed()
{
	current_move_speed = gamepad_button_check(global.player_gamepad, default_control_scheme.run) ? run_speed : walk_speed;
	current_move_speed *= delta;
}

function calculate_movement_and_look_ratios()
{
	move_x = gamepad_axis_value(global.player_gamepad, default_control_scheme.horizontal_move);
	move_x = (abs(move_x) > global.gamepad_deadzone) ? move_x: 0;
	move_y = gamepad_axis_value(global.player_gamepad, default_control_scheme.vertical_move);
	move_y = (abs(move_y) > global.gamepad_deadzone) ? move_y : 0;
	var _normalized_values = normalize(move_x, move_y);
	move_x = _normalized_values._x * current_move_speed;
	move_y = _normalized_values._y * current_move_speed;
	horizontal_look_ratio = gamepad_axis_value(global.player_gamepad, default_control_scheme.horizontal_look)
	horizontal_look_ratio = (abs(horizontal_look_ratio) > global.gamepad_deadzone) ? horizontal_look_ratio : (move_x != 0 ? move_x : last_valid_horizontal_look_ratio);
	vertical_look_ratio = gamepad_axis_value(global.player_gamepad, default_control_scheme.vertical_look)
	vertical_look_ratio = (abs(vertical_look_ratio) > global.gamepad_deadzone) ? vertical_look_ratio : (move_y != 0 ? move_y : last_valid_vertical_look_ratio);
	if (horizontal_look_ratio != last_valid_horizontal_look_ratio)
	{
		last_valid_horizontal_look_ratio = horizontal_look_ratio;
	}
	if (vertical_look_ratio != last_valid_vertical_look_ratio)
	{
		last_valid_vertical_look_ratio = vertical_look_ratio;
	}
	// Direction facing
	if (horizontal_look_ratio != 0)
	{
		image_xscale = sign(horizontal_look_ratio);
	}
}

function default_movement()
{
	if (global.player_gamepad != -1)
	{
		calculate_current_move_speed();
		calculate_movement_and_look_ratios();
		
		// Handle movement and collision seperately (prevents one axis of collisison from stopping all movement)
		move_and_collide(move_x, 0, obj_collision);
		move_and_collide(0, move_y, obj_collision);
	}
}