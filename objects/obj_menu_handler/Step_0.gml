if (global.player_gamepad != -1 && gamepad_button_check_pressed(global.player_gamepad, gp_start))
{
	switch (is_game_paused)
	{
	case true:
		instance_activate_all();
		break;
	case false:
		instance_deactivate_all(true);
		instance_activate_layer("utility");
		break;
	}
	is_game_paused = !is_game_paused;
}