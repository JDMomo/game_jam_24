// Define sprites
var idle_sprite = spr_player_idle1;
var walk_sprite = spr_player_walk;
var run_sprite = spr_player_run;
var jump_sprite = spr_player_jump;
var glide_sprite = spr_player_glide;
var crouch_sprite = spr_player_crouch;
var punch_sprite = spr_player_punch;

// Define speeds
var walkspeed = 4;
var runspeed = 6;
var crouchSpeed = 2; // Define in Create event

// Check for inverted controls
if (timer >= invertControlsDuration) {
    isControlsInverted = true;
}

// Input checks
var shift_pressed = keyboard_check(vk_shift);
var _right = (isControlsInverted ? keyboard_check(vk_left) : keyboard_check(vk_right)) || (isControlsInverted ? keyboard_check(ord("A")) : keyboard_check(ord("D")));
var _left = (isControlsInverted ? keyboard_check(vk_right) : keyboard_check(vk_left)) || (isControlsInverted ? keyboard_check(ord("D")) : keyboard_check(ord("A")));
var _xinput = _right - _left;
var isCrouching = keyboard_check(vk_down) || keyboard_check(ord("S"));
var punch_pressed = keyboard_check(ord("E"));

// Initialize isGliding
var isGliding = false;

// Determine movement speed
var current_speed = walkspeed;
if (shift_pressed) {
    current_speed = runspeed;
}
if (isCrouching) {
    current_speed = crouchSpeed;
}

// Punch logic
if (punch_pressed) {
    isPunching = true;
    canBypassWalls = true;
} else {
    isPunching = false;
    canBypassWalls = false;
}

// Handle gliding
if (keyboard_check(vk_space) && !place_meeting(x, y + 1, obj_ground) && vspd > 0) {
    vspd = max(vspd - 0.8, _glideSpeed);
    isGliding = true;
}

// Horizontal movement
var _hspd = _xinput * current_speed;

if (object_exists(obj_wall) && !canBypassWalls && place_meeting(x + _hspd, y, obj_wall)) {
    while (!place_meeting(x + sign(_hspd), y, obj_wall)) {
        x += sign(_hspd);
    }
    _hspd = 0;
}
x += _hspd;

// Apply gravity
if (!place_meeting(x, y + 1, obj_ground)) {
    vspd += _gravity;
} else {
    vspd = 0;
}

// Jump and glide logic
if (keyboard_check_pressed(vk_space)) {
    if (place_meeting(x, y + 1, obj_ground)) {
        vspd = _jumpSpeed;
        _canDoubleJump = true;
    } else if (_canDoubleJump) {
        vspd = _jumpSpeed;
        _canDoubleJump = false;
    }
}

// Vertical collision
if (object_exists(obj_wall) && !canBypassWalls && place_meeting(x, y + vspd, obj_wall)) {
    while (!place_meeting(x, y + sign(vspd), obj_wall)) {
        y += sign(vspd);
    }
    vspd = 0;
}
y += vspd;

// Sprite management
if (isPunching) {
    sprite_index = punch_sprite;
    image_speed = 1; // Ensure animation speed is set
} else if (isGliding) {
    sprite_index = glide_sprite;
    image_speed = 1;
} else if (vspd != 0) {
    sprite_index = jump_sprite;
    image_speed = 1;
} else if (isCrouching) {
    sprite_index = crouch_sprite;
    image_speed = 0;
} else if (_xinput != 0) {
    sprite_index = shift_pressed ? run_sprite : walk_sprite;
    image_speed = 1;
} else {
    sprite_index = idle_sprite;
    image_speed = 0;
}

// Update sprite direction
if (_hspd > 0) {
    image_xscale = 1;
} else if (_hspd < 0) {
    image_xscale = -1;
}

// Update timer and check for effects
timer += 1;
if (timer >= zoomDuration) {
    isZoomActive = true;
}
if (timer >= redTintDuration) {
    isRedTintActive = true;
}
if (timer >= invertColorDuration) {
    isInvertedColorActive = true;
}

// Check for collision with obj_finishline and transition to next room
if (place_meeting(x, y, obj_finishline)) {
    // Transition to the next room
    room_goto_next();
}

// Restart game on pressing "P"
if (keyboard_check_pressed(ord("P"))) {
    game_restart();
}
