extends Panel

@onready var menu_bar = $MarginContainer/VBoxContainer/TabContainer/VBoxContainer2/HBoxContainer/MenuButton

func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,value)

func _on_effects_volum_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value)

func _on_dictor_volum_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(3,value)


func _on_menu_button_about_to_popup() -> void:
	if menu_bar.text == "keep":
		print("keep")
