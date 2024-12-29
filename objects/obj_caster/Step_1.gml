/// @description 

event_inherited();

var _mana_increase = max_mana * (percent_mana_regen_per_second / 100) * ((tick_count - last_regen_tick) / global.ticks_per_second);
last_regen_tick = tick_count;
if (current_mana + _mana_increase > max_mana)
{
	current_mana = max_mana;	
}
else
{
	current_mana += _mana_increase;
}