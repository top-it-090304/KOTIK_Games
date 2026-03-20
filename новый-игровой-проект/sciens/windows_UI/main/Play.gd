extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://sciens/windows_UI/main_screen/menu_container.tscn")
