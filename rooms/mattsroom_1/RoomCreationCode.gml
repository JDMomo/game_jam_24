global.canGlide = false

if (room == title_screen) {
    audio_play_sound(snd_intro, true, 1); // Play intro sound
} else if (room == mattsroom) {
    audio_play_sound(snd_room1, true, 1); // Play room 1 music
} else if (room == mattsroom_1) {
    audio_play_sound(snd_room2, true, 1); // Play room 2 music
} else if (room == mattsroom_2) {
    audio_play_sound(snd_room3, true, 1); // Play room 3 music
} else if (room == mattsroom_3) {
    audio_play_sound(snd_room4, true, 1); // Play room 4 music
} else if (room == mattsroom_4) {
    audio_play_sound(snd_room5, true, 1); // Play room 5 music
} else if (room == mattsroom_5) {
    audio_play_sound(snd_room6, true, 1); // Play room 6 music
} else if (room == victory_screen) {
    audio_play_sound(snd_finish, true, 1); // Play victory sound
} else if (room == Credit_screen) {
    audio_play_sound(snd_outro, true, 1); // Play outro sound
}



