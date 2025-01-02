/// @description

event_inherited();

set_entity_type(id, EntityType.Friendly);

health_status_bar = instance_create_layer(0, 0, "ui", obj_player_status_bar, {gui_x : 1, gui_y : 0, status_percent : 0, r : 1.0, b : 0.3});
mana_status_bar = instance_create_layer(0, 0, "ui", obj_player_status_bar, {gui_x : 1, gui_y : obj_player_status_bar.sprite_height, status_percent : 0, required_percent : global.spell_dictionary.get_spell_mana_cost(prepared_spells[selected_spell_index].spell_id) / max_mana, r : 0.3, b : 1.0, g : 0.4});

/// @function		calculate_current_move_speed();
/// @description	calculate a player's movement speed and apply a fixed delta time to it.
function calculate_current_move_speed()
{
	current_move_speed = gamepad_button_check(global.player_gamepad, default_control_scheme.run) ? run_speed : walk_speed;
	calculate_fixed_delta_move_speed();
}

/// @function		calculate_movement_and_look_ratios();
/// @description	calculate a player's movement and look ratios with respect to their gamepad. Set a player's image_xscale in accordance to their faced direction.
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

/// @function		default_movement();
/// @description	preform player based movment operations under the default control scheme.
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