shader_type canvas_item;


uniform float progress : hint_range(0.0, 1.0);
uniform vec4 base_color  : source_color = vec4(0.9, 0.0, 0.0, 0.1);
uniform vec4 med_color   : source_color = vec4(0.9, 0.0, 0.0, 0.4);
uniform vec4 high_color  : source_color = vec4(0.9, 0.0, 0.0, 0.9);
uniform vec4 flash_color : source_color = vec4(0.9, 0.8, 0.8, 1.0);

void fragment() {
    // Result color
    vec4 color;

	// Slow profress at the beggining and more intense the closer to the end
    if (progress < 0.6) {
        color = mix(base_color, med_color, progress / 0.6);
    } else {
        color = mix(med_color, high_color, (progress - 0.6) / 0.4);
    }

    // Effects to the color to make some flicker
    color += sin(TIME * 10.0) * 0.05 * progress;
    color *= 1.0 + (sin(TIME * 40.0) * 0.1 * progress);

    // FLASH pre-explosion (95% → 100%)
    if (progress > 0.9) {
        float t = (progress - 0.95) / 0.05;
        float flash = abs(sin(progress * 50.0));
        color = mix(color, flash_color, flash * t);
    }

    COLOR = color;
}
