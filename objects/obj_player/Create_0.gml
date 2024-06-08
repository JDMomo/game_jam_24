// Define constants
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
redTintDuration = 4 * room_speed; // 30 seconds in game frames
invertColorDuration = 4 * room_speed; // 40 seconds in game frames
isRedTintActive = false; // Flag to check if red tint is active
isInvertedColorActive = false; // Flag to check if color inversion is active

// Initialize punch variables
isPunching = false;
punchCounter = 0;
punchCooldown = 2 * room_speed; // Punch lasts for 2 seconds
canBypassWalls = false;
