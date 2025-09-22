shader_type canvas_item;

uniform sampler2D grayscaleImage : filter_nearest;
uniform vec4 lowColor : source_color;
uniform vec4 midColor : source_color;
uniform vec4 highColor : source_color;
uniform float shake_intensity = 0.0;
uniform float shake_speed = 20.0;
void fragment() {
	// Called for every pixel the material is visible on.
	vec4 grayscaleTexture = texture(grayscaleImage, UV);
	float grayscaleValue = grayscaleTexture.r;
	float alphaValue = grayscaleTexture.a;
	
	vec4 color = mix(lowColor,midColor,grayscaleValue);
	color = mix(color, highColor, pow(grayscaleValue, 2.0));
	color.a *= alphaValue;
	COLOR = color;
}

void vertex() {
	// Called for every vertex the material is visible on.
	vec2 shake = vec2(0.0);
	if (VERTEX.y < 0.0) {
		shake.x = sin(TIME * shake_speed + VERTEX.y) * shake_intensity;
	}
	VERTEX.xy += shake;
}

