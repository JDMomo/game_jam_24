// Handle input
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _jump = keyboard_check_pressed(vk_space); // Detect when spacebar is pressed
var _restart = keyboard_check_pressed(ord("P")); // Detect when P is pressed

// Apply gravity
if (!place_meeting(x, y + 1, obj_ground)) {
    // If not colliding with the ground, apply gravity
    vspd += _gravity;
} else {
    // Reset vertical speed when colliding with the ground
    vspd = 0;
}

// Handle jumping
if (_jump) {
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

// Calculate movement based on inputs
var _xinput = _right - _left;

// Move horizontally
var _hspd = _xinput * my_speed;

// Apply horizontal and vertical speed to the player's position
x += _hspd;
y += vspd;

// Restart the room if P is pressed
if (_restart) {
    room_restart();
}