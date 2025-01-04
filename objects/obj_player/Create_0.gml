/// @description

event_inherited();

set_entity_type(id, EntityType.Friendly);

health_status_bar = instance_create_layer(0, 0, "ui", obj_player_status_bar, {gui_x : 1, gui_y : 0, status_percent : 0, r : 1.0, b : 0.3});
mana_status_bar = instance_create_layer(0, 0, "ui", obj_player_status_bar, {gui_x : 1, gui_y : obj_player_status_bar.sprite_height, status_percent : 0, required_percent : global.spell_dictionary.get_spell_mana_cost(prepared_spells[selected_spell_index].spell_id) / max_mana, r : 0.3, b : 1.0, g : 0.4});
visible_spell_slot_01 = instance_create_layer(0, 0, "ui", obj_player_spell_slot, {gui_x : 1 + health_status_bar.sprite_width + spr_player_spell_slot.sprite_index.sprite_width , gui_y : spr_player_spell_slot.sprite_index.sprite_height});
visible_spell_slot_02 = instance_create_layer(0, 0, "ui", obj_player_spell_slot, {gui_x : visible_spell_slot_01.gui_x + spr_player_spell_slot.sprite_index.sprite_width * 2 , gui_y : spr_player_spell_slot.sprite_index.sprite_height, spell : prepared_spells[selected_spell_index].spell_id});
visible_spell_slot_03 = instance_create_layer(0, 0, "ui", obj_player_spell_slot, {gui_x : visible_spell_slot_02.gui_x + spr_player_spell_slot.sprite_index.sprite_width * 2 , gui_y : spr_player_spell_slot.sprite_index.sprite_height});

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
	move_y = gamepad_axis_value(global.player_gamepad, default_control_scheme.vertical_move);
	horizontal_look_ratio = gamepad_axis_value(global.player_gamepad, default_control_scheme.horizontal_look)
	vertical_look_ratio = gamepad_axis_value(global.player_gamepad, default_control_scheme.vertical_look)
	// Look axis takes priority over move axis
	if (horizontal_look_ratio == 0 && vertical_look_ratio == 0)
	{
		horizontal_look_ratio = (move_x != 0 ? move_x : last_valid_horizontal_look_ratio);
		vertical_look_ratio = (move_y != 0 ? move_y : last_valid_vertical_look_ratio);
	}
	// Gamemaker gamepad_axis_value already normalizes the return
	move_x *= current_move_speed;
	move_y *= current_move_speed;
	last_valid_horizontal_look_ratio = horizontal_look_ratio;
	last_valid_vertical_look_ratio = vertical_look_ratio;
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