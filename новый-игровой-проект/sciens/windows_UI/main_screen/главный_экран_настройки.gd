extends Panel

#@onready var menu_bar = $MarginContainer/VBoxContainer/TabContainer/VBoxContainer2/HBoxContainer/MenuButton
var music_volume = 0 
var effects_volum = 0.0 
var dictor_volum  = 0



func _on_music_volume_value_changed(value: float) -> void:
	music_volume = value

func _on_effects_volum_value_changed(value: float) -> void:
	effects_volum = value
	print(effects_volum)

func _on_dictor_volum_value_changed(value: float) -> void:
	dictor_volum = value
	


func _on_menu_button_about_to_popup() -> void:
	#if menu_bar.text == "keep":
	#	print("keep")
	pass
