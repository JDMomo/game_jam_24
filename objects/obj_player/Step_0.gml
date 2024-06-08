// o_player Step Event

// Define sprites
var idle_sprite = spr_player_idle; // The idle sprite
var walk_sprite = spr_player_walk; // The walking sprite
var run_sprite = spr_player_run; // The running sprite
var jump_sprite = spr_player_jump; // The jump sprite
var glide_sprite = spr_player_glide; // The glide sprite

// Define speeds
var walkspeed = 4; // The walking speed
var runspeed = 6; // The running speed

// Check if Shift key is pressed
var shift_pressed = keyboard_check(vk_shift);

// Determine the current speed and sprite
var current_speed = shift_pressed ? runspeed : walkspeed;
var current_sprite = shift_pressed ? run_sprite : walk_sprite;

// Horizontal movement input
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _xinput = _right - _left;

// Move horizontally
var _hspd = _xinput * current_speed;
x += _hspd;

// Apply gravity
if (!place_meeting(x, y + 1, obj_ground)) {
    // If not colliding with the ground, apply gravity
    vspd += _gravity;
} else {
    // Reset vertical speed when colliding with the ground
    vspd = 0;
}

// Handle jumping
if (keyboard_check_pressed(vk_space)) {
    if (place_meeting(x, y + 1, obj_ground)) {
        // If spacebar is pressed and character is on the ground, perform regular jump
        vspd = _jumpSpeed;
        _canDoubleJump = true; // Allow double jump after regular jump
    } else if (_canDoubleJump) {
        // If spacebar is pressed and character is in mid-air and has not used double jump yet, perform double jump
        vspd = _jumpSpeed;
        _canDoubleJump = false; // Double jump used, disable it until landing again
    }
}

// Handle gliding
var isGliding = false;
if (keyboard_check(vk_space) && !place_meeting(x, y + 1, obj_ground) && vspd > 0) {
    // If spacebar is held down, character is not colliding with the ground, and character is descending, glide
    vspd = max(vspd - 0.8, _glideSpeed); // Decrease vertical speed gradually to simulate gliding to the ground
    isGliding = true;
}

// Update vertical position
y += vspd;

// Check for horizontal movement to switch sprites
if (isGliding) {
    // Set glide sprite when the player is gliding
    sprite_index = glide_sprite;
    image_speed = 1; // Set to the desired animation speed
} else if (vspd != 0) {
    // Set jump sprite when the player is in the air and not gliding
    sprite_index = jump_sprite;
    image_speed = 1; // Set to the desired animation speed
} else if (_hspd != 0) {
    // Set moving sprite when the player is moving horizontally
    sprite_index = current_sprite;
    image_speed = 1; // Set to the desired animation speed
} else {
    // Set idle sprite when the player is not moving
    sprite_index = idle_sprite;
    image_speed = 0; // Stop animation for idle sprite
}

// Adjust sprite based on direction
if (_hspd > 0) {
    image_xscale = 1; // Face right
} else if (_hspd < 0) {
    image_xscale = -1; // Face left
}

// Restart the game when pressing the P key
if (keyboard_check_pressed(ord("P"))) {
    game_restart();
}
