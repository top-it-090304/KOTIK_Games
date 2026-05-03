extends Control


@onready var animation = $AnimationPlayer
@onready var Speaker = $Speaker





func _on_play_pressed() -> void:
	Speaker.sound_efect("B1")
	get_tree().change_scene_to_file("res://sciens/windows_UI/Распределение ролей/control_расп.tscn") 


func _on_options_pressed() -> void:
	Speaker.sound_efect("B1")
	animation.play("action2")

func _on_quit_pressed() -> void:
	Speaker.sound_efect("B1")
	get_tree().quit()


func _on_back_pressed() -> void:
	Speaker.sound_efect("B1")
	animation.play_backwards("action2")
