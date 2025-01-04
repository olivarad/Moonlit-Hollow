/// @function		assign_player_gamepad();
/// @description	assign player gamepad from available gamepads.
function assign_player_gamepad()
{
	for (var _i = 0; _i < max_gamepad_connections; ++_i)
	{
		if (gamepad_is_connected(_i))
		{
			for (var _button = gp_face1; _button <= gp_padr; ++_button)
			{
				if (gamepad_button_check(_i, _button))
				{
					gamepad_set_axis_deadzone(_i, global.gamepad_deadzone);
					global.player_gamepad = _i;
					return;
				}
			}
			for (var _axis = gp_axislh; _axis <= gp_axisrv; ++_axis)
			{
				if (abs(gamepad_axis_value(_i, _axis)) > global.gamepad_deadzone)
				{
					gamepad_set_axis_deadzone(_i, global.gamepad_deadzone);
					global.player_gamepad = _i;
					return;
				}
			}
		}
	}
}

/// @function		player_gamepad_connection_check();
/// @description	check if player gamepad is still connected.
function player_gamepad_connection_check()
{
	if (global.player_gamepad != -1 && !gamepad_is_connected(global.player_gamepad))
	{
		global.player_gamepad = -1;	
	}
}