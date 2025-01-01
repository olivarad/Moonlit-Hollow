/// @description

event_inherited();

//health_status_bar = instance_create_layer(camera.x + sprite_width + 5, camera.y + camera.height - sprite_height, "ui", obj_player_status_bar, {status_percent : 0, r : 1.0, b : 0.3});
//mana_status_bar = instance_create_layer(health_status_bar.x + sprite_width * 2 + 5, health_status_bar.y, "ui", obj_player_status_bar, {status_percent : 0, b : 0.8, g : 0.5});
health_status_bar.x = camera.x - camera.width / 2 + health_status_bar.sprite_width / 2 + 1;
health_status_bar.y = camera.y - camera.height / 2 + health_status_bar.sprite_height / 2 + 1;
mana_status_bar.x = health_status_bar.x;
mana_status_bar.y = health_status_bar.y + mana_status_bar.sprite_height + 1;
health_status_bar.status_percent = current_health / max_health;
mana_status_bar.status_percent = current_mana / max_mana;