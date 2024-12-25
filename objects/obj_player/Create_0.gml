function calculate_current_move_speed()
{
	current_move_speed = gamepad_button_check(global.player_gamepad, default_control_scheme.run) ? run_speed : walk_speed;
	current_move_speed *= delta;
}

function calculate_movement()
{
	move_x = gamepad_axis_value(global.player_gamepad, default_control_scheme.horizontal_move);
	move_x = (abs(move_x) > global.gamepad_deadzone) ? move_x * current_move_speed: 0;
	move_y = gamepad_axis_value(global.player_gamepad, default_control_scheme.vertical_move);
	move_y = (abs(move_y) > global.gamepad_deadzone) ? move_y * current_move_speed : 0;
	// Direction facing
	if (move_x != 0)
	{
		image_xscale = sign(move_x);
	}
}

function default_movement()
{
	if (global.player_gamepad != -1)
	{
		calculate_current_move_speed();
		calculate_movement();
		
		// Handle movement and collision seperately (prevents one axis of collisison from stopping all movement)
		move_and_collide(move_x, 0, obj_collision);
		move_and_collide(0, move_y, obj_collision);
	}
}