/// @description Insert description here
// You can write your code in this editor
if (!audio_is_playing(snd_background)) {
    audio_play_sound(snd_background, 1, true); // Play the sound, loop it
}
