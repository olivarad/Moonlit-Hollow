// Set the shader
shader_set(shader_status_bar);

// Set the uniform for the input color
var color_uniform = shader_get_uniform(shader_status_bar, "u_colour");
shader_set_uniform_f(color_uniform, r, g, b, a); // Assign color

// Set the uniform for the percentage
var percentage_uniform = shader_get_uniform(shader_status_bar, "u_percentage");
shader_set_uniform_f(percentage_uniform, status_percent);

// Draw the sprite at the fixed position
if (sprite_index != -1) {
    draw_sprite_ext(
        sprite_index,    // Current sprite
        image_index,     // Current frame
        gui_x,            // Fixed X position in GUI layer
        gui_y,            // Fixed Y position in GUI layer
        image_xscale,    // Scale X
        image_yscale,    // Scale Y
        image_angle,     // Rotation
        image_blend,     // Color blend
        image_alpha      // Transparency
    );
}

// Reset the shader
shader_reset();
