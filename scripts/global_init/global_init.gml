gml_pragma("global", "global_init()");
global.tick_duration = 50;
global.ticks_per_second = 1000 / global.tick_duration;
global.gamepad_deadzone = 0.01;
global.player_gamepad = -1;
enum EntityType // Total 7 or 111
{
	Friendly = 1,
	Neutral = 2,
	Enemy = 4
};
enum TargetModifier
{
	Opposite,
	NotSame,
	Same
}
enum DamageType
{
	Neutral,
	Force,
	Bludgeoning,
	Piercing,
	Slashing,
	Fire,
	Ice,
	Lightning,
	Thunder,
	Psychic,
	Necrotic,
	Radiant,
	Poison,
	Heal
};
return;