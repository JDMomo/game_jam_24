// Collision Event with obj_finishline
if (place_meeting(x, y, obj_finishline)) {
    room_goto_next(); // Transition to the next room
    global.canGlide = false; // Disable glide in the next room
}

// Create Event of obj_global_variables
