var _spawn_point = instance_find(obj_spawn_point, 0);
if (_spawn_point)
{
	instance_create_layer(_spawn_point.x, _spawn_point.y, "foreground", obj_player, {spawn_point : _spawn_point});	
}