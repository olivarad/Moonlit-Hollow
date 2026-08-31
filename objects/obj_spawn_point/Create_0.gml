if (connected_room_noone_behavior != noone)
{
	switch (connected_room_noone_behavior)
	{
		case ConnectedRoomNooneBehavior.GenerateDungeon:
			if (global.active_dungeon_instance != noone)
			{
				var _room_and_spawn_point = create_dungeon(connected_spawn_point_desired_edge_face);
				connected_room = _room_and_spawn_point._room;
				connected_spawn_point = _room_and_spawn_point._spawn_point_object;
			}
		break;
	}
}