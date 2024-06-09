if (room == title_screen) {
    audio_play_sound(snd_intro, true); // Play level 1 music
} else if (room == mattsroom) {
    audio_play_sound(snd_room1, true); // Play level 2 music
} else if (room == mattsroom_1) {
    audio_play_sound(snd_room2, true); // Play level 2 music
} else if (room == mattsroom_2) {
    audio_play_sound(snd_room3, true); // Play level 2 music
} else if (room == mattsroom_3) {
    audio_play_sound(snd_room4, true); // Play level 2 music
} else if (room == mattsroom_4) {
    audio_play_sound(snd_room5, true); // Play level 2 music
} else if (room == mattsroom_5) {
    audio_play_sound(snd_room5, true); // Play level 2 music
} else if (room == victory_screen) {
    audio_play_sound(snd_finish, true); // Play level 2 music
} else if (room == Credit_screen) {
    audio_play_sound(snd_outro, true); // Play level 2 music
}
// Repeat the pattern for the other rooms
