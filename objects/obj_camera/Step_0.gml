// Step Event of obj_camera

// Find the player object
var player = instance_find(obj_player, 0);

if (player != noone) { // If player object exists
    // Original and zoomed view sizes
    var view_w_original = 320; // Original view width
    var view_h_original = 240; // Original view height
    var zoom_w = 64; // Zoomed-in width
    var zoom_h = 64; // Zoomed-in height

    // Determine target view width and height based on zoom state
    var target_view_w = view_w_original;
    var target_view_h = view_h_original;
    if (player.isZoomActive) {
        target_view_w = zoom_w;
        target_view_h = zoom_h;
    }

    // Interpolate view size smoothly
    var view_w_current = camera_get_view_width(view_camera[0]);
    var view_h_current = camera_get_view_height(view_camera[0]);
    var view_w_new = lerp(view_w_current, target_view_w, 0.1);
    var view_h_new = lerp(view_h_current, target_view_h, 0.1);
    camera_set_view_size(view_camera[0], view_w_new, view_h_new);

    // Smoothly adjust camera position to center on the player
    var target_x = player.x - view_w_new / 2;
    var target_y = player.y - view_h_new / 2;
    var lerp_speed = 0.1; // Adjust the lerp speed for desired smoothness
    var new_x = lerp(camera_get_view_x(view_camera[0]), target_x, lerp_speed);
    var new_y = lerp(camera_get_view_y(view_camera[0]), target_y, lerp_speed);
    camera_set_view_pos(view_camera[0], new_x, new_y);
}
