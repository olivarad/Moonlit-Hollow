/// @description 

if (sprite_index != -1) {
    draw_sprite_ext(
        sprite_index,    // Current sprite
        image_index,     // Current frame
        display_get_gui_width() / 2,            // Fixed X position in GUI layer
        display_get_gui_height() / 2,            // Fixed Y position in GUI layer
        image_xscale,    // Scale X
        image_yscale,    // Scale Y
        image_angle,     // Rotation
        image_blend,     // Color blend
        image_alpha      // Transparency
    );
}