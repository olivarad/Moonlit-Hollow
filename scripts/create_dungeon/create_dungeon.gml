/// @function			create_dungeon(first_spawn_point_edge_face)
/// @param		first_spawn_point_edge_face edge face of first spawn point (entrance)
/// @returns		Struct First dungeon room and dungeon entrance
/// @description		create minimal dungeon.
function create_dungeon(first_spawn_point_edge_face)
{
	if (global.active_dungeon_instance == noone)
	{
		// Create and initialize dungeon room array
		global.active_dungeon_instance = array_create(global.dungeon_edge_size, array_create(global.dungeon_edge_size));
		for (var _i = 0; _i < global.dungeon_edge_size; ++_i)
		{
			for (var _j = 0; _j < global.dungeon_edge_size; ++_j)
			{
				global.active_dungeon_instance[_i][_j] = room_add();
				room_assign(global.active_dungeon_instance[_i][_j], room_base);
				/*room_set_camera(global.active_dungeon_instance[_i][_j], 0, camera_create());
				room_set_viewport(global.active_dungeon_instance[_i][_j], 0, true, 0, 0, 1280, 720);
				room_set_view_enabled(global.active_dungeon_instance[_i][_j], true);*/
			}
		}
		if (first_spawn_point_edge_face != noone)
		{
			var _room_and_spawn_point = {_room: noone, _spawn_point_object: noone};
			// Dungeon entrance at top edge [0][y]
			if (first_spawn_point_edge_face == RoomEdgeFaces.TopLeft || first_spawn_point_edge_face == RoomEdgeFaces.Top || first_spawn_point_edge_face == RoomEdgeFaces.TopRight)
			{
				_room_and_spawn_point._room = global.active_dungeon_instance[0][irandom_range(0, global.dungeon_edge_size - 1)];			
			}
			// Dungeon entrance at right edge [x][global.dungeon_edge_size - 1]
			else if (first_spawn_point_edge_face == RoomEdgeFaces.RightTop || first_spawn_point_edge_face == RoomEdgeFaces.Right || first_spawn_point_edge_face == RoomEdgeFaces.RightBottom)
			{
				_room_and_spawn_point._room = global.active_dungeon_instance[irandom_range(0, global.dungeon_edge_size - 1)][global.dungeon_edge_size - 1];
			}
			// Dungeon entrance at bottom edge [global.dungeon_edge_size - 1][y]
			else if (first_spawn_point_edge_face == RoomEdgeFaces.BottomRight || first_spawn_point_edge_face == RoomEdgeFaces.Bottom || first_spawn_point_edge_face == RoomEdgeFaces.BottomLeft)
			{
				_room_and_spawn_point._room = global.active_dungeon_instance[global.dungeon_edge_size - 1][irandom_range(0, global.dungeon_edge_size - 1)];
			}
			// Dungeon entrance at left edge [x][0]
			else if (first_spawn_point_edge_face == RoomEdgeFaces.LeftBottom || first_spawn_point_edge_face == RoomEdgeFaces.Left || first_spawn_point_edge_face == RoomEdgeFaces.LeftTop)
			{
				_room_and_spawn_point._room = global.active_dungeon_instance[irandom_range(0, global.dungeon_edge_size - 1)][0];
			}
			else
			{
				show_debug_message("create_dungeon: invalid usage");
				game_end(1);
			}
			_room_and_spawn_point._spawn_point_object = room_instance_add(_room_and_spawn_point._room, 0, 0, obj_spawn_point);
			return _room_and_spawn_point;
		}
		else
		{
			show_debug_message("create_dungeon: invalid usage");
			game_end(2);
		}
	}
	else
	{
		show_debug_message("create_dungeon: invalid usage");
		game_end(3);
	}
}