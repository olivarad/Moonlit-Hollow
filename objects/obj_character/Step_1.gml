/// @description 
delta = (delta_time / 1000000) * 60;

milliseconds_since_last_tick += delta_time / 1000;

if (milliseconds_since_last_tick >= global.tick_duration)
{
    // Calculate how many ticks have passed
    var processed_ticks = floor(milliseconds_since_last_tick / global.tick_duration);
    tick_count += processed_ticks;

    // Preserve the leftover time
    milliseconds_since_last_tick -= processed_ticks * global.tick_duration;
}

health_regen();