extends Control

@onready var ras_rol = $Play/MarginContainer

@onready var play_panel = $Play
@onready var test_panel = $Menu

@onready var dalee_button: Button = $Play/MarginContainer/VBoxContainer/HBoxContainer2/Button2

@onready var label = $Test/Label

@onready var pan = $Menu/PanelContainer3

signal value_changed(all_count)

#Переменные со всей информацией
var all_count: int = 2
var mafia_count: int = 0
var don_count: int = 0
var doc_count: int = 0
var mir_count: int = 0
var sh_count: int = 0
var yes: int = 0


func _ready() -> void:
	hide_all_panels()
	play_panel.show()
	dalee_button.pressed.connect(dalee_pressed)


func hide_all_panels():
	play_panel.hide()
	test_panel.hide()


func dalee_pressed():
	hide_all_panels()
	all_count = ras_rol.all_count
	mafia_count = ras_rol.old_count_M
	don_count = ras_rol.old_count_don
	doc_count = ras_rol.old_count_doc
	mir_count = ras_rol.old_count_mir
	sh_count = ras_rol.old_count_sh
	#label.text = str(all_count)
	test_panel.show()
	pan.hide()
	Vvod()
	value_changed.emit(all_count)
	
func Vvod():
	print(all_count)
	print(mafia_count)
	print(don_count)
	print(doc_count)
	print(mir_count)
	print(sh_count)
