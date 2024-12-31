/// @function			normalize(val_x, val_y);
/// @param {real}		val_x
///	@param {real}		val_y
/// @returns {Struct}	normalized x and y values
/// @description		normalizes input x and y values.
function normalize(val_x, val_y)
{
	var _magnitude = sqrt(sqr(val_x) + sqr(val_y));
	if (_magnitude != 0)
	{
		val_x /= _magnitude;
		val_y /= _magnitude;
	}
	return {_x : val_x, _y : val_y};
}