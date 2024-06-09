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
if (keyboard_check(vk_space) && !place_meeting(x, y + 1, obj_ground) && vspd > 0 && global.canGlide) {
    vspd = max(vspd - 0.8, _glideSpeed);
    isGliding = true;
} else {
    isGliding = false;
}


// Horizontal movement
var _hspd = _xinput * current_speed;

// Apply gravity
vspd += _gravity;

// Handle horizontal collisions
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

// Handle vertical collisions
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

y += vspd;

// Handle jumping and double jump
if (jump_pressed) {
    if (place_meeting(x, y + 1, obj_ground) || place_meeting(x, y + 1, obj_disappearing_block)) {
        // Regular jump
        vspd = _jumpSpeed;
    } else if (_canDoubleJump && global.canDoubleJump) {
        // Double jump
        vspd = _jumpSpeed;
        _canDoubleJump = false; // Disable double jump after using it
    }
}

// Handle jumping and double jump
if (jump_pressed) {
    if ((place_meeting(x, y + 1, obj_ground) || place_meeting(x, y + 1, obj_disappearing_block))) {
        // Regular jump
        vspd = _jumpSpeed;
    } else if (_canDoubleJump && global.canDoubleJump) {
        // Double jump
        vspd = _jumpSpeed;
        _canDoubleJump = false; // Disable double jump after using it
    }
}

// Enable double jump when grounded
if (place_meeting(x, y + 1, obj_ground) || place_meeting(x, y + 1, obj_disappearing_block)) {
    _canDoubleJump = true;
}

// Disable double jump if finish line touched twice
if (global.finishlineTouches >= 2) {
    global.canDoubleJump = false;
} else {
    global.canDoubleJump = true; // Re-enable double jump if the finish line has not been touched twice
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

// Step Event of obj_player

// Increment the tick timer
tick_timer += 1;

// Check if it's time to increase health
if (tick_timer >= tick_interval) {
    tick_timer = 0;
    health += health_fill_speed;
    
    // Check if health exceeds max_health
    if (health >= max_health) {
        health = 0; // Reset health
        health_cycle_count += 1; // Increment the cycle count
        
        // Change health bar color
        if (health_cycle_count < max_cycles) {
            current_health_color = health_colors[health_cycle_count % array_length(health_colors)];
        }
    }
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
