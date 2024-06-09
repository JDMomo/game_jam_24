// Collision Event with obj_player
if (other.id == obj_player) {
    global.finishlineTouches += 1; // Increment the finish line touches count
    if (global.finishlineTouches >= 2) {
        global.canDoubleJump = false; // Disable double jump after touching finish line 2 times
    }
    room_goto_next(); // Transition to the next room
}
