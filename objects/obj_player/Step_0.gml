// Step Event for obj_player

// Define sprites
var idle_sprite = spr_player_idle1;
var walk_sprite = spr_player_walk;
var run_sprite = spr_player_run1;
var jump_sprite = spr_player_jump1;
var glide_sprite = spr_player_glide_1;
var crouch_sprite = spr_player_crouch1;
var punch_sprite = spr_player_punch1;

// Define speeds
var walkspeed = 4;
var runspeed = 6;
var crouchSpeed = 2; // Speed while crouching

// Input checks
var shift_pressed = keyboard_check(vk_shift);
var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _xinput = _right - _left;
var isCrouching = keyboard_check(vk_down) || keyboard_check(ord("S"));
var punch_pressed = keyboard_check_pressed(ord("E"));
var jump_pressed = keyboard_check_pressed(vk_space);
var reset_pressed = keyboard_check_pressed(ord("P")); // Check for level reset

// Update controls if inverted
if (timer >= invertControlsDuration) {
    isControlsInverted = true;
}

if (isControlsInverted) {
    _xinput = -_xinput;
}

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

// Handle punch input
if (punch_pressed && punchCounter <= 0) {
    isPunching = true;
    punchCounter = punchCooldown;
    canBypassWalls = true; // Enable collision bypass
}

// Reduce punch counter if it's above 0
if (punchCounter > 0) {
    punchCounter -= 1;
    if (punchCounter <= 0) {
        isPunching = false;
        canBypassWalls = false; // Disable collision bypass after punch
    }
}

// Handle gliding
if (keyboard_check(vk_space) && !place_meeting(x, y + 1, obj_ground) && vspd > 0) {
    vspd = max(vspd - 0.8, _glideSpeed);
    isGliding = true;
} else {
    isGliding = false;
}

// Horizontal movement
var _hspd = _xinput * current_speed;

// Horizontal collision handling
if (!canBypassWalls) {
    if (place_meeting(x + _hspd, y, obj_wall) || place_meeting(x + _hspd, y, obj_ground) || place_meeting(x + _hspd, y, obj_disappearing_block)) {
        while (!place_meeting(x + sign(_hspd), y, obj_wall) &&
               !place_meeting(x + sign(_hspd), y, obj_ground) &&
               !place_meeting(x + sign(_hspd), y, obj_disappearing_block)) {
            x += sign(_hspd);
        }
        _hspd = 0;
    }
}

x += _hspd;

// Apply gravity
vspd += _gravity;

// Vertical collision handling
if (!canBypassWalls) {
    if (vspd > 0) {
        // Moving down
        if (place_meeting(x, y + vspd, obj_wall) || place_meeting(x, y + vspd, obj_ground) || place_meeting(x, y + vspd, obj_disappearing_block)) {
            while (!place_meeting(x, y + 1, obj_wall) &&
                   !place_meeting(x, y + 1, obj_ground) &&
                   !place_meeting(x, y + 1, obj_disappearing_block)) {
                y += 1;
            }
            vspd = 0;
        }
    } else if (vspd < 0) {
        // Moving up
        if (place_meeting(x, y + vspd, obj_wall) || place_meeting(x, y + vspd, obj_ground) || place_meeting(x, y + vspd, obj_disappearing_block)) {
            while (!place_meeting(x, y - 1, obj_wall) &&
                   !place_meeting(x, y - 1, obj_ground) &&
                   !place_meeting(x, y - 1, obj_disappearing_block)) {
                y -= 1;
            }
            vspd = 0;
        }
    }
}

y += vspd;

// Handle jumping and double jump
if (jump_pressed) {
    if (place_meeting(x, y + 1, obj_ground) || place_meeting(x, y + 1, obj_disappearing_block)) {
        vspd = _jumpSpeed;
        _canDoubleJump = true;
    } else if (_canDoubleJump) {
        vspd = _jumpSpeed;
        _canDoubleJump = false;
    }
}

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
if (timer >= invertControlsDuration) {
    isControlsInverted = true;
}

// Check for collision with obj_finishline and transition to next room
if (place_meeting(x, y, obj_finishline)) {
    room_goto_next(); // Transition to the next room
}

// Restart level on pressing "P"
if (reset_pressed) {
    room_restart();
}

