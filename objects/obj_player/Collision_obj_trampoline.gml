/// @description Insert description here
// You can write your code in this editor
// Collision Event with obj_trampoline in obj_player
if (instance_place(x, y, obj_trampoline)) {
    // Perform actions when the player touches the trampoline
    // For example, you can handle the jumping behavior here
    vspd = -50; // Adjust jump_height according to your game
}
