extends Control

@onready var play_panel = $PlayPanel
@onready var settings_panel = $SettingsPanel
@onready var exit_panel = $ExitPanel
@onready var main_panel = $MainPanel

func _ready():
	# Скрываем все панели при запуске
	hide_all_panels()
	main_panel.show()

func hide_all_panels():
	play_panel.hide()
	settings_panel.hide()
	exit_panel.hide()
	main_panel.hide()

	

func _on_settings_button_pressed():
	hide_all_panels()
	settings_panel.show()

func _on_exit_button_pressed():
	hide_all_panels()
	exit_panel.show()
	get_tree().quit()

func _on_back_button_pressed():
	hide_all_panels()	
	main_panel.show()


func _on_plau_batton_pressed() -> void:
	hide_all_panels()
	play_panel.show()
