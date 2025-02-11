/// @description 
final_tick_count = global.fixed_delta_timer.tick_count + spell[? "duration_ticks"];
var _sprite_pool = spell[? "sprite_pool"];
if (ds_map_exists(spell, "effective_damage_type")) // damage type and sprite are unrelated
{
	damage_type = spell[? "effective_damage_type"];
	var _sprite_pool_index = spell[? "sprite_pool_index"];
	sprite_index = _sprite_pool[_sprite_pool_index];
}
else // damage type and sprite MAY be related
{
	if (ds_map_exists(spell, "effective_damage_type_and_sprite_index")) // damage type and sprite are related
	{
		var _damage_type_bag_randomizer = spell[? "damage_type_bag_randomizer"];
		var _sprite_pool_bag_randomizer = spell[? "sprite_pool_bag_randomizer"];
		var _effective_damage_type_and_sprite_index = spell[? "effective_damage_type_and_sprite_index"];
		damage_type = _damage_type_bag_randomizer[_effective_damage_type_and_sprite_index];
		sprite_index = _sprite_pool_bag_randomizer[_effective_damage_type_and_sprite_index];
		array_delete(_damage_type_bag_randomizer, _effective_damage_type_and_sprite_index, 1);
		array_delete(_sprite_pool_bag_randomizer, _effective_damage_type_and_sprite_index, 1);
	}
	else // damage type and sprite are unrelated
	{
		var _damage_type_array = spell[? "damage_type_array"];
		damage_type = _damage_type_array[spell[? "effective_damage_type_index"]];
		sprite_index = _sprite_pool[spell[? "sprite_pool_index"]];
	}
}
if (target)
{    
    var TARGET_RELATIVE_X = target.x - caster_id.x;
    var TARGET_RELATIVE_Y = target.y - caster_id.y;
    
    // Calculate A, B, and C for the quadratic equation
    var A = sqr(target.move_x) + sqr(target.move_y) - sqr(spell[? "movement_speed"]);
    var B = 2 * (TARGET_RELATIVE_X * target.move_x + TARGET_RELATIVE_Y * target.move_y);
    var C = sqr(TARGET_RELATIVE_X) + sqr(TARGET_RELATIVE_Y);
    
    var DISCRIMINANT = sqr(B) - 4 * A * C;
    
    if (DISCRIMINANT >= 0 && A != 0)
    {
        // Calculate both possible times
        var time_componet = (-B + sqrt(DISCRIMINANT)) / (2 * A);
        var temp = (-B - sqrt(DISCRIMINANT)) / (2 * A);
        
        // Ensure time_componet is non-negative
        if (time_componet < 0)
        {
            time_componet = temp;  // Switch to the other root if time_componet is negative
        }
        
        // Ensure temp is also non-negative (if it's better than the initial time_componet)
        if (temp >= 0 && temp < time_componet)
        {
            time_componet = temp;    
        }
        // Check if time_componet is within acceptable range
        if (time_componet >= 0 && time_componet <= spell[? "duration_ticks"])
        {
            // Compute the unit vectors and move the caster
			show_debug_message(time_componet)
            var UNIT_VECTOR_X = (target.x + target.move_x * time_componet) / (spell[? "movement_speed"] * time_componet);
            var UNIT_VECTOR_Y = (target.y + target.move_y * time_componet) / (spell[? "movement_speed"] * time_componet);
            move_x = spell[? "movement_speed"] * UNIT_VECTOR_X;
            move_y = spell[? "movement_speed"] * UNIT_VECTOR_Y;
			//show_debug_message($"move_x: {move_x}, move_y: {move_y}");
            show_debug_message($"{UNIT_VECTOR_X}, {UNIT_VECTOR_Y}");
			image_angle = arctan2(UNIT_VECTOR_Y, UNIT_VECTOR_X);
        }
        else
        {
            var _angle = point_direction(caster_id.x, caster_id.y, target.x, target.y);
            move_x = spell[? "movement_speed"] * cos(degtorad(_angle));
            move_y = -spell[? "movement_speed"] * sin(degtorad(_angle));
            image_angle = _angle;
        }
    }
    else
    {
        // If discriminant is negative, fallback to a simpler movement calculation
        var _angle = point_direction(caster_id.x, caster_id.y, target.x, target.y);
        move_x = spell[? "movement_speed"] * cos(degtorad(_angle));
        move_y = -spell[? "movement_speed"] * sin(degtorad(_angle));
        image_angle = _angle;
    }
}
else
{
	move_x = spell[? "movement_speed"] * caster_id.horizontal_look_ratio;
	move_y = spell[? "movement_speed"] * caster_id.vertical_look_ratio;
	image_angle = caster_id.look_angle;
}
if (spell[? "movement_pattern"] == MovementPattern.Circle)
{
	angle = caster_id.look_angle; // Already in radians
	radius = radius_multiplier * (sqrt(sqr(caster_id.sprite_width) + sqr(caster_id.sprite_height)) + sqrt(sqr(sprite_width) + sqr(sprite_height)));
	var _movment_ratio = global.target_framerate / global.ticks_per_second;
	x = caster_id.x + radius * (global.fixed_delta_timer.delta / _movment_ratio) * cos(angle);
	y = caster_id.y + radius * (global.fixed_delta_timer.delta / _movment_ratio) * sin(angle);
	angle += angle_increment * global.fixed_delta_timer.delta / _movment_ratio;
}
var _sprite_pool_index = spell[? "sprite_pool_index"];
global.spell_dictionary.randomize_spell_sprite_and_primary_damage_type(spell);

/// @function		spell_behavior();
/// @description	preform spell behavoir as defined in a spell's dictionary table.
function spell_behavior()
{
	if (global.fixed_delta_timer.tick_count >= final_tick_count)
	{
		instance_destroy();
	}
	image_angle += spell[? "per_delta_rotation"] * global.fixed_delta_timer.delta;
	var _movment_ratio = global.target_framerate / global.ticks_per_second;
	switch (spell[? "movement_pattern"])
	{
		case MovementPattern.Standard:
			x += move_x * (global.fixed_delta_timer.delta / _movment_ratio);
			y += move_y * (global.fixed_delta_timer.delta / _movment_ratio);
			break;
		case MovementPattern.Missile:
			if (target)
			{
				var _angle = point_direction(caster_id.x, caster_id.y, target.x, target.y);
				move_x = spell[? "movement_speed"] * cos(degtorad(_angle));
				move_y = -spell[? "movement_speed"] * sin(degtorad(_angle));
				x += move_x * (global.fixed_delta_timer.delta / _movment_ratio);
				y += move_y * (global.fixed_delta_timer.delta / _movment_ratio);
				if (spell[? "per_delta_rotation"] == 0)
				{
					image_angle = _angle;	
				}
			}
			else
			{
				x += move_x * (global.fixed_delta_timer.delta / _movment_ratio);
				y += move_y * (global.fixed_delta_timer.delta / _movment_ratio);
			}
			break;
		case MovementPattern.Circle:
			// angle in radians
			x = caster_id.x + radius * (global.fixed_delta_timer.delta / _movment_ratio) * cos(angle);
			y = caster_id.y + radius * (global.fixed_delta_timer.delta / _movment_ratio) * sin(angle);
			angle += angle_increment * global.fixed_delta_timer.delta / _movment_ratio;
			break;
	}
}