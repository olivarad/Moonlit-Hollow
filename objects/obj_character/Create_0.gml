/// @description 

function calculate_fixed_delta_move_speed()
{
	current_move_speed *= global.fixed_delta_timer.delta;
}

function health_regen()
{
	if (current_health != max_health)
	{
		var _health_increase = max_health * (percent_health_regen_per_second / 100) * ((global.fixed_delta_timer.tick_count - last_regen_tick) / global.ticks_per_second);
		if (current_health + _health_increase > max_health)
		{
			current_health = max_health;	
		}
		else
		{
			current_health += _health_increase;
		}
	}
}