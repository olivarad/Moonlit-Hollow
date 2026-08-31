if (gamepad_button_check_pressed(global.player_gamepad, default_control_scheme.open_spellbook))
{
	if (is_spellbook_open)
	{
		instance_activate_layer("ui");
		instance_deactivate_object(spellbook);
	}
	else
	{
		instance_deactivate_layer("ui");
		instance_activate_object(spellbook);
	}
	is_spellbook_open = !is_spellbook_open;
}

if (!is_spellbook_open)
{
	default_movement();

	if (global.player_gamepad != -1 && gamepad_button_check(global.player_gamepad, default_control_scheme.cast_spell))
	{
		cast_attempt();
	}
	
	if (global.player_gamepad != -1 && gamepad_button_check(global.player_gamepad, gp_shoulderlb) && global.active_dungeon_instance == noone)
	{
		var _room_and_spawn_point = create_dungeon(RoomEdgeFaces.Right);
		room_goto(_room_and_spawn_point._room);
	}
}