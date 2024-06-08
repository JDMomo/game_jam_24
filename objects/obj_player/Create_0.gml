
// Define constants
my_speed = 3;
_jumpSpeed = -10;
_gravity = 0.5;
vspd = 0;
_glideSpeed = 1; // Adjust as needed (this controls how fast the character descends while gliding)
_canDoubleJump = true; // Allow double jump after regular jump
// Initial sprite direction (1 for right, -1 for left)
facing = 1;
_crouchSpeed = 2; // Speed while crouching

// Create event of obj_player
isPunching = false; // Flag to check if player is punching
punchCooldown = 10; // Frames before player can punch again
punchCounter = 0; // Counter to manage cooldown
canBypassWalls = false; // Flag to bypass wall collisions when punching

_hspd = 0;
