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
	Random = 1,
	Neutral = 2,
	Force = 4,
	Bludgeoning = 8,
	Piercing = 16,
	Slashing = 32,
	Fire = 64,
	Ice = 128,
	Lightning = 256,
	Thunder = 512,
	Psychic = 1024,
	Necrotic = 2048,
	Radiant = 4096,
	Poison = 8192,
	Heal = 16384
};
return;