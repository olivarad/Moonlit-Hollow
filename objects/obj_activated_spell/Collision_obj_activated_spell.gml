/// @description Colliding spells destory each other
if (other.id.caster_id != caster_id)
{
	instance_destroy();
}
else if (other.id.spell[? "spell_id"] != spell[? "spell_id"])
{
	instance_destroy();
}