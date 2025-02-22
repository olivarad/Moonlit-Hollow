event_inherited();

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
		for (var _i = 0; _i < ds_list_size(_actual_targets); ++_i)
		{
			with (_actual_targets[| _i])
			{
				alert();
			}
		}
	}
}