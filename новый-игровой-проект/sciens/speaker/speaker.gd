extends Control

@onready var player_speaker = $Speaker
@onready var player_efects = $Speaker
@onready var player_musics = $Speaker

var phrases = {
	"City_wake_up":"res://audio/Фразы/MP3/City_wake_up.mp3",
	"Doctor_falling_asleep":"res://audio/Фразы/MP3/Doctor_falling_asleep.mp3",
	"Doctor_wake_up":"res://audio/Фразы/MP3/Doctor_wake_up.mp3",
	"Mafia_falling_asleep":"res://audio/Фразы/MP3/Mafia_falling_asleep.mp3",
	"Mafia_wake_up":"res://audio/Фразы/MP3/Mafia_wake_up.mp3"
}

var musics = {
	1:"res://audio/Фразы/City_wake_up.mp3",
	2:"res://audio/Фразы/Mafia_wake_up.mp3"
}

var efects = {
	"upheaval":"res://audio/Переворот карты1.mp3"
}

func speaker_phrases(phrases_name):
	player_speaker.set_stream(load(phrases[phrases_name]))
	player_speaker.volume_db = AudioServer.get_bus_volume_db(3)
	player_speaker.play()

func musics_play(musics_name):
	player_musics.stream(load(musics[musics_name]))
	player_musics.volume_db = AudioServer.get_bus_volume_db(2)
	player_musics.play()

func sound_efect(efects_name):
	player_efects.set_stream(load(efects[efects_name]))
	player_efects.volume_db = AudioServer.get_bus_volume_db(1)
	player_efects.play()
