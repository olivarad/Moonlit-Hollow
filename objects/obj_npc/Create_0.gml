event_inherited();

if (patrol_pattern == NPCPatrolPattern.Linear || patrol_pattern == NPCPatrolPattern.RandomCentered)
{
	patrol_center = {_x: x, _y: y};	
}

/// @function		obtain_targets_in_range(range);
/// @param {real}	range effective_radius
/// @returns		Id.DsList characters in range
/// @description	obtain targets in range of range radius
function obtain_targets_in_range(range)
{
	var _targets = ds_list_create();
	collision_circle_list(x, y, range, obj_character, false, true, _targets, false);
	return _targets;
}

/// @function		calculate_view_targets();
/// @returns		Id.DsList characters in sight
/// @description	find all charcters able to be seen
function calculate_view_targets()
{
	// Obtain targets in sight_radius
	var _possible_targets = obtain_targets_in_range(sight_radius);
	
	// Remove targets out of sight_angle
	for (var _i = ds_list_size(_possible_targets) - 1; _i >= 0; --_i)
	{
		var _possible_target = ds_list_find_value(_possible_targets, _i);
		var _angle_difference = abs(angle_difference(point_direction(x, y, _possible_target.x, _possible_target.y), radtodeg(-look_angle)));
		if (_angle_difference > look_angle) // not within sight
		{
			ds_list_delete(_possible_targets, _i);
		}
	}
	
	return _possible_targets;
}

/// @function		alert();
/// @description	set alerted flag
function alert()
{
	alerted = true;	
}

/// @function		communicate();
/// @description	communicate if neccessary
function communicate()
{
	// Obtain known list of communication targets
	var _targets = calculate_view_targets();
	var _count_my_entity_type = 0; // number of entities matching entity type in list
	for (var _i = 0; _i < ds_list_size(_targets); ++_i)
	{
		var _item = _targets[| _i];
		if (_item.entityType == entity_type)
		{
			++_count_my_entity_type;	
		}
	}
	var _ratio_my_entity_type = _count_my_entity_type / ds_list_size(_targets);
	
	// Only communicate if doing so would put you at an advantage
	if (_ratio_my_entity_type >= communication_threshold)
	{
		// Obtain actual list of communication targets
		var _actual_targets = obtain_targets_in_range(communication_radius);
		
		// Communicate
		for (var _i = ds_list_size(_actual_targets) - 1; _i >= 0; --_i)
		{
			if (_actual_targe[|_i].entityType == entity_type)
			{
				with (_actual_targets[| _i])
				{
					alert();
				}	
			}
		}
	}
}

/// @function		patrol();
/// @description	patrol if not alerted
function patrol()
{
	// Don't patrol if npc has a better destination
	if (alerted)
	{
		return;
	}
	
	current_move_speed = walk_speed;
	
	if (patrol_pattern != noone)
	{
		// Set patrol_target and start point
		if (patrol_target._x == noone || patrol_target._y == noone || (x == patrol_target._x && y == patrol_target._y))
		{
			switch (patrol_pattern)
			{
				case NPCPatrolPattern.Linear:
					if (patrol_center._x == noone || patrol_center._y == noone || patrol_direction == noone)
					{
						show_debug_message("patrol: invalid usage");
						game_end(1);
					}
					if (patrol_direction == NPCPatrolDireciton.Random)
					{
						patrol_direction = irandom(NPCPatrolDireciton.Random-1);
					}
					
					linear_patrol_distance =  random_range(6 * current_move_speed, 12 * current_move_speed);

					switch (patrol_direction)
					{
						case NPCPatrolDireciton.Horizontal:
							patrol_target._x = (x >= patrol_center._x ?  patrol_center._x - linear_patrol_distance :  patrol_center._x + linear_patrol_distance);
							patrol_target._y = patrol_center._y;
						break;
					
						case NPCPatrolDireciton.Vertical:
							patrol_target._x = patrol_center._x;
							patrol_target._y = (y >= patrol_center._y ? patrol_center._y - linear_patrol_distance : patrol_center._y + linear_patrol_distance);
						break;
					}
				break;
		
				case NPCPatrolPattern.RandomCentered:
		
				break;
		
				case NPCPatrolPattern.Random:
		
				break;
			}
		}
		// Patrol
		switch (patrol_pattern)
		{
			case NPCPatrolPattern.Linear:
				calculate_fixed_delta_move_speed();
				switch (patrol_direction)
				{
				case NPCPatrolDireciton.Horizontal:
					move_x = current_move_speed;
					if (x > patrol_target._x)
					{
						look_angle = 180;
						move_and_collide(-move_x, 0, obj_collision);
					}
					else
					{
						look_angle = 0;
						move_and_collide(move_x, 0, obj_collision);
					}
					if (linear_patrol_distance <= abs(x - patrol_center._x))
					{
						patrol_target._x = noone;
						patrol_target._y = noone;
					}
				break;
				
				case NPCPatrolDireciton.Vertical:
					move_y = current_move_speed;
					if (y > patrol_target._y)
					{
						look_angle = 270;
						move_and_collide(0, -move_y, obj_collision);
					}
					else
					{
						look_angle = 90;
						move_and_collide(0, move_y, obj_collision);
					}
					if (linear_patrol_distance <= abs(y - patrol_center._y))
					{
						patrol_target._x = noone;
						patrol_target._y = noone;
					}
				break;
				}
			break;
		}
	}
}