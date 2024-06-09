// Step Event of obj_disappearing_block

if (isTouched) {
    touchTimer -= 1; // Decrement the timer
    
    if (touchTimer <= 0) {
        // Destroy the block
        instance_destroy();
    }
}
