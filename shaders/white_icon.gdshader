shader_type canvas_item;

const float brightness = 0.65f;
const float hover_brightness = 0.8f;
instance uniform bool hover;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float curr_brightness = hover ? hover_brightness : brightness;
	COLOR = vec4(curr_brightness, curr_brightness, curr_brightness, color.a);
}

