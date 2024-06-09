// Step Event of obj_disappearing_block

if (isTouched) {
    // Decrement the timer
    touchTimer -= 1;

    // Check if the timer has reached 0
    if (touchTimer <= 0) {
        // Destroy the block
        instance_destroy();
    }
}
