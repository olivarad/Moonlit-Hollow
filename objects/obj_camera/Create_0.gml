x_to = x;
y_to = y;

/// @function		calculate_destination();
/// @description	calculate camera destination.
function calculate_destination()
{
	var _proposed_x_to = follow_target.x;
	var _proposed_y_to = follow_target.y;
	x_to = abs(x_to - _proposed_x_to) > jitter_mantissa ? _proposed_x_to : x_to;
	y_to = (abs(y_to - _proposed_y_to) > jitter_mantissa ? _proposed_y_to : y_to);
}