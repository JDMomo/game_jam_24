// Apply shader for color inversion if the timer has reached the duration
if (isInvertedColorActive) {
    shader_set(shd_invert);
}

// Draw the player as usual
draw_self();

// Reset shader
if (isInvertedColorActive) {
    shader_reset();
}

// Draw red tint if the timer has reached the red tint duration
if (isRedTintActive) {
    draw_set_alpha(0.5);
    draw_set_color(c_red);
    draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
