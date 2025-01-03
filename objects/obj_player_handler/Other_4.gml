var _spawn_point = instance_find(obj_spawn_point, 0);
if (_spawn_point)
{
	player.x = _spawn_point.x;
	player.y = _spawn_point.y;
	instance_activate_object(obj_player);
	instance_activate_object(obj_camera);
}
else
{
	instance_deactivate_object(obj_player);	
}