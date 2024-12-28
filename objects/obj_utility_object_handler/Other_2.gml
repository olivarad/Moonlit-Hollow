global.fixed_delta_timer = instance_create_layer(0, 0, "utility", obj_delta_time_handler);
instance_create_layer(x, y, "utility", obj_player_handler);
instance_create_layer(x, y, "utility", obj_controller_handler);
instance_create_layer(x, y, "utility", obj_menu_handler);