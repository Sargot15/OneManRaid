shader_type canvas_item;

uniform float hit_time = 0.0; // time left for this effect in seconds

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // avoid drawing transparent pixels
    if (tex.a < 0.1) {
        discard;
    }

    // if there is time left for this effect, we interpolate it
    if (hit_time > 0.0) {
        float t = hit_time / 0.5;  // 0.5 is the max time, right now it is defined here AND in the gdscript
        t = clamp(t, 0.0, 0.75);
        COLOR = mix(tex, vec4(1.0, 0.0, 0.0, tex.a), t); // fade the color
    } else {
        COLOR = tex;
    }
}
