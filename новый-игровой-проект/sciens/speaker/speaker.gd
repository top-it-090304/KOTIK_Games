extends Control

@onready var player_speaker = $Speaker
@onready var player_efects = $Speaker
@onready var player_musics = $Speaker

@onready var options = get_node("/root/ГлавныйЭкранНастройки")

var phrases = {
	"helloy":"res://audio/Фразы/Пред началом игры/helloy.mp3",
	"city_falling_asleep":"res://audio/Фразы/Пред началом игры/city_falling_asleep.mp3",
	"mafia_waking_up":"res://audio/Фразы/Мафия/mafia_waking_up.mp3",
	"mafia_falling_asleep":"res://audio/Фразы/Мафия/mafia_falling_asleep.mp3",
	"don_waking_up":"res://audio/Фразы/Дон/don_waking_up.mp3",
	"don_faling_sleap":"res://audio/Фразы/Дон/don_faling_sleap.mp3",
	"doctor_waking_up":"res://audio/Фразы/Доктор/doctor_waking_up.mp3",
	"doctor_falling_asleep":"res://audio/Фразы/Доктор/doctor_falling_asleep.mp3",
	"sherif_waking_up":"res://audio/Фразы/Шериф/sherif_waking_up.mp3",
	"sherif_falling_asleep":"res://audio/Фразы/Шериф/sherif_falling_asleep.mp3",
	"good_morning":"res://audio/Фразы/День/good_morning.mp3",
	"faling_sleep":"res://audio/Фразы/День/faling_sleep.mp3"
}

var musics = {
	1:"res://audio/Фразы/City_wake_up.mp3",
	2:"res://audio/Фразы/Mafia_wake_up.mp3"
}

var efects = {
	"upheaval":"res://audio/Переворот карты1.mp3",
	"B1":"res://audio/Звуки кнопок/a30aa53e7ecd230.mp3",
	"B2":"res://audio/Звуки кнопок/f6d54e81f69d38d.mp3"
}



func speaker_phrases(phrases_name):
	player_speaker.set_stream(load(phrases[phrases_name]))
	player_speaker.volume_db = ГлавныйЭкранНастройки.dictor_volum
	player_speaker.play()

func musics_play(musics_name):
	player_musics.stream(load(musics[musics_name]))
	if ГлавныйЭкранНастройки.music_volume == null:
		player_musics.volume_db = 0
	else:
		player_musics.volume_db = ГлавныйЭкранНастройки.music_volume
	
	player_musics.play()

func sound_efect(efects_name):
	if options.effects_volum == null:
		player_musics.volume_db = 0
	else:
		player_musics.volume_db = options.effects_volum
	player_efects.set_stream(load(efects[efects_name]))
	print(options.effects_volum )
	player_efects.play()
