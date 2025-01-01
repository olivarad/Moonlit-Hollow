//
// Fragment shader to replace white pixels with a gradient effect
//
varying vec2 v_vTexcoord;
uniform vec4 u_colour;       // The base color to apply
uniform float u_percentage;  // A percentage value (0.0 to 1.0)
uniform float u_white_start_x;  // The x-coordinate where the white region starts
uniform float u_white_end_x;    // The x-coordinate where the white region ends

void main()
{
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);

    // Check if the pixel is white
    if (texColor.rgb == vec3(1.0))
	{
		float relativeX = (v_vTexcoord.x - u_white_start_x) / (u_white_end_x - u_white_start_x);
		relativeX = clamp(relativeX, 0.0, 1.0);
		
        // If the x-coordinate is beyond the percentage, make the white pixel transparent
        if (v_vTexcoord.x > u_percentage)
		{
            gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0); // Fully transparent
        }
		else
		{
            // Calculate the transition factor based on the x-coordinate and the percentage
            float factor = smoothstep(0.0, u_percentage, v_vTexcoord.x);

            // Create a gradient effect between black (vec3(0.0)) and the base color (u_colour.rgb)
            vec3 startColor = mix(vec3(0.0), u_colour.rgb, 0.2);
            vec3 modifiedColor = mix(startColor, u_colour.rgb, factor);

            // Apply the gradient effect, maintaining the original alpha
            gl_FragColor = vec4(modifiedColor, texColor.a);
        }
    }
	else
	{
        // Retain non-modifiable colors
        gl_FragColor = texColor;
    }
}
