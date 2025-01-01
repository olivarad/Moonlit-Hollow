// Set the shader
shader_set(shader_status_bar);

// Set the uniform for the input color
var color_uniform = shader_get_uniform(shader_status_bar, "u_colour");
shader_set_uniform_f(color_uniform, r, g, b, a); // Assign color

// Set the uniform for the percentage
var percentage_uniform = shader_get_uniform(shader_status_bar, "u_percentage");
shader_set_uniform_f(percentage_uniform, status_percent);

// Draw the sprite
draw_self();

// Reset the shader
shader_reset();
