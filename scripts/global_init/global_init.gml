gml_pragma("global", "global_init()");
global.tick_duration = 50;
global.ticks_per_second = 1000 / global.tick_duration;
global.gamepad_deadzone = 0.1
global.player_gamepad = -1;
global.aim_assist_angle = 20;
global.target_framerate = 60;
game_set_speed(60, gamespeed_fps);
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
enum DamageType // exponets for powers of 2
{
	Neutral = 1,
	Force = 2,
	Bludgeoning = 4,
	Piercing = 8,
	Slashing = 16,
	Fire = 32,
	Ice = 64,
	Lightning = 128,
	Thunder = 256,
	Psychic = 512,
	Necrotic = 1024,
	Radiant = 2048,
	Poison = 4096,
	Heal = 8192
};

global.non_heal_damage_types = [DamageType.Neutral, DamageType.Force, DamageType.Bludgeoning, DamageType.Piercing, DamageType.Slashing, DamageType.Fire, DamageType.Ice, DamageType.Lightning, DamageType.Thunder, DamageType.Psychic, DamageType.Necrotic, DamageType.Radiant, DamageType.Poison];

return;