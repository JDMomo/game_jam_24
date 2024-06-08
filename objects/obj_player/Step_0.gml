// Handle input
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _jump = keyboard_check_pressed(vk_space); // Detect when spacebar is pressed
var _glide = keyboard_check(vk_space); // Detect if spacebar is held down
var _restart = keyboard_check_pressed(ord("P")); // Detect when P is pressed
var _crouch = keyboard_check(vk_down) || keyboard_check(ord("S")); // Detect when down arrow or S is pressed

// Restart the room if P is pressed
if (_restart) {
    room_restart();
}

// Handle crouching
if (_crouch) {
    if (!_isCrouching) {
        _isCrouching = true;
        image_yscale = _crouchHeight; // Change to crouch height
        // Adjust the collision mask or sprite origin if needed
    }
} else {
    if (_isCrouching) {
        _isCrouching = false;
        image_yscale = _normalHeight; // Reset to normal height
        // Adjust the collision mask or sprite origin if needed
    }
}

// Apply gravity
if (!place_meeting(x, y + vspd, obj_ground)) {
    if (_glide && vspd > _glideSpeed) {
        // If gliding and falling faster than glide speed, apply glide speed
        vspd = _glideSpeed;
        _isGliding = true;
    } else {
        // Apply gravity normally
        vspd += _gravity;
        _isGliding = false;
    }
} else {
    // Reset vertical speed when colliding with the ground
    vspd = 0;
    _isGliding = false;
}

// Handle jumping
if (_jump && !_isGliding && !_isCrouching) {
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
