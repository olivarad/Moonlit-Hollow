calculate_destination();

x += (x_to - x) / camera_speed;
y += (y_to - y) / camera_speed;

camera_set_view_pos(view_camera[0], x - (width / 2), y - (height / 2));