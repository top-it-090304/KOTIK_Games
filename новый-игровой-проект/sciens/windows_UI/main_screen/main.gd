extends Control

@onready var ofline = preload("res://sciens/windows_UI/Распределение ролей/control_расп.tscn")
@onready var play_panel = $"Главный_экран_1"
@onready var settings_panel = $"Главный_экран_Настройки"



func hide_all_panels():
	play_panel.hide()
	settings_panel.hide()


func _on_играть_pressed() -> void:
	get_tree().change_scene_to_file("res://sciens/windows_UI/Распределение ролей/control_расп.tscn") 


func _on_настройки_pressed() -> void:
	hide_all_panels()
	settings_panel.show()


func _on_выход_pressed() -> void:
	get_tree().quit()
