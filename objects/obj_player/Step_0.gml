default_movement();

if (global.player_gamepad != -1 && gamepad_button_check(global.player_gamepad, default_control_scheme.cast_spell))
{
	cast_attempt();
}