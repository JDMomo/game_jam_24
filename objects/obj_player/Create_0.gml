// Create Event of obj_player
my_speed = 3;
_jumpSpeed = -10;
_gravity = 0.5;
vspd = 0;
_glideSpeed = 1; // Adjust as needed
_canDoubleJump = true;
crouchSpeed = 2; // Speed while crouching

// Initial sprite direction (1 for right, -1 for left)
facing = 1;

// Initialize timer and duration for effects
timer = 0;
zoomDuration = 300 * room_speed; // 20 seconds in game frames
redTintDuration = 303 * room_speed; // 30 seconds in game frames
invertColorDuration = 403 * room_speed; // 40 seconds in game frames
invertControlsDuration = 503 * room_speed; // 50 seconds in game frames
isZoomActive = false; // Flag to check if zoom is active
isRedTintActive = false; // Flag to check if red tint is active
isInvertedColorActive = false; // Flag to check if color inversion is active
isControlsInverted = false; // Flag to check if controls are inverted

// Initialize punch variables
isPunching = false;
punchCounter = 0;
punchCooldown = 2 * room_speed; // Punch lasts for 2 seconds
canBypassWalls = false;

// Initialize player health
_health = 100; // Example health value
max_health = 100; // Maximum health value

// Create Event of obj_player

// Health variables
max_health = 60;
_health = 0;
health_fill_speed = 1; // Health ticks up by 1 every second
health_cycle_count = 0;
max_cycles = 3;

// Color cycle array
health_colors = [c_red, c_green, c_blue];
current_health_color = health_colors[0];

// Timing variables
tick_timer = 0;
tick_interval = room_speed; // 1 second in game frames

// Create Event of obj_player
restart_count = 0; // Variable to track the number of restarts
// Create Event of obj_global_variables


