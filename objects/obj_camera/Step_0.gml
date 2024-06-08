/// @description Insert description here
// You can write your code in this editor
// Step Event of obj_camera
var player = instance_find(obj_player, 0); // Find the player object

if (player != noone) { // If player object exists
    // Smoothly adjust camera position to center on the player
    var target_x = player.x - view_wview[0] / 2;
    var target_y = player.y - view_hview[0] / 2;
    
    // Use lerp to interpolate between current camera position and target position
    var lerp_speed = 0.1; // Adjust the lerp speed for desired smoothness
    camera_set_view_pos(view_camera[0], lerp(camera_get_view_x(view_camera[0]), target_x, lerp_speed), lerp(camera_get_view_y(view_camera[0]), target_y, lerp_speed));
}