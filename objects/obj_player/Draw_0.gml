// Draw Event of obj_player

// Draw the player
draw_self();

// Get the camera view position
var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);

// Set the position and dimensions for the HUD, relative to the view
var hud_x = view_x + 10;
var hud_y = view_y + 10;
var hud_width = 200;
var hud_height = 20;
var health_percentage = health / max_health;

// Draw the background of the health bar
draw_set_color(c_black);
draw_rectangle(hud_x - 2, hud_y - 2, hud_x + hud_width + 2, hud_y + hud_height + 2, false);

// Draw the health bar with the current color
draw_set_color(current_health_color);
draw_rectangle(hud_x, hud_y, hud_x + (hud_width * health_percentage), hud_y + hud_height, false);

// Draw the border of the health bar
draw_set_color(c_white);
draw_rectangle(hud_x, hud_y, hud_x + hud_width, hud_y + hud_height, true);

// Draw health text
draw_set_color(c_white);
draw_text(hud_x + hud_width / 2 - 15, hud_y + 2, string(health) + " / " + string(max_health));

// Reset color
draw_set_color(c_white);

// Apply shader for color inversion if the timer has reached the duration
if (isInvertedColorActive) {
    shader_set(shd_invert);
    draw_self(); // Draw the player with shader
    shader_reset();
}

// Draw red tint if the timer has reached the red tint duration
if (isRedTintActive) {
    draw_set_alpha(0.5);
    draw_set_color(c_red);
    draw_rectangle(view_x, view_y, view_x + display_get_width(), view_y + display_get_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
