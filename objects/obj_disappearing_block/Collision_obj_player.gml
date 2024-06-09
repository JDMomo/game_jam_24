// Collision Event with obj_player

// If the block has not already been touched
if (!isTouched) {
    isTouched = true; // Set touched flag to true
    touchTimer = 1 * room_speed; // Set timer for 2 seconds (2 seconds * frames per second)
}
