extends Control


@onready var animation = $AnimationPlayer






func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://sciens/windows_UI/Распределение ролей/control_расп.tscn") 


func _on_options_pressed() -> void:
	animation.play("action2")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	animation.play_backwards("action2")
