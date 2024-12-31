var _spawn_point = instance_find(obj_spawn_point, 0);
if (_spawn_point)
{
	player.x = _spawn_point.x;
	player.y = _spawn_point.y;
	instance_activate_object(obj_player);
	instance_activate_object(obj_camera);
	instance_create_layer(_spawn_point.x + 64, _spawn_point.y, "foreground", obj_dummy_target);
}
else
{
	instance_deactivate_object(obj_player);	
}