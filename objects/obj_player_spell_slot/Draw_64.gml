/// @description

draw_sprite_ext(
        sprite_index,	// Current sprite
        image_index,	// Current frame
        gui_x,			// Fixed X position in GUI layer
        gui_y,			// Fixed Y position in GUI layer
        image_xscale,	// Scale X
        image_yscale,	// Scale Y
        image_angle,	// Rotation
        image_blend,	// Color blend
        image_alpha		// Transparency
    );


if (spell != 0)
{
	var _spell_sprite = global.spell_dictionary.get_spell_sprite(spell);
	var _scale_x = available_space / sprite_get_width(_spell_sprite);
	var _scale_y = available_space / sprite_get_height(_spell_sprite);
	var _scale = min(_scale_x, _scale_y);
	draw_sprite_ext(
        _spell_sprite,	// Current sprite
        0,				// Current frame
        gui_x,			// Fixed X position in GUI layer
        gui_y,			// Fixed Y position in GUI layer
        _scale,			// Scale X
        _scale,			// Scale Y
        0,				// Rotation
        c_white,		// Color blend
        1				// Transparency
    );
}