extends Control

@onready var ras_rol = $Play/MarginContainer

@onready var play_panel = $Play
@onready var panel = $Panel
@onready var menu_panel = $Menu

@onready var dalee_button: Button = $Play/MarginContainer/VBoxContainer/HBoxContainer2/Button2

@onready var pan = $Menu/PanelContainer3

#Test
@onready var Daleerol: Button = $Panel/MarginContainer/VBoxContainer/Button


signal value_changed(all_count)
signal name_changed(name_arr)

#Переменные со всей информацией
var all_count: int = 0
var mafia_count: int = 0
var don_count: int = 0
var doc_count: int = 0
var mir_count: int = 0
var sh_count: int = 0
var a: int = 0
var rand: int = 0
var ind: int = 0
var pl_name_glob: String = " "

var player_panels = []  # массив для хранения созданных панелей
var current_panel_index: int = 0  # индекс текущей панели

var rol_arr = []
var name_arr = []

func _ready() -> void:
	hide_all_panels()
	play_panel.show()
	dalee_button.pressed.connect(dalee_pressed)

func app_name(player_name):
	pl_name_glob = player_name

func hide_all_panels():
	play_panel.hide()
	menu_panel.hide()
	panel.hide()


func app_arr_rol():
	for i in range(mafia_count):
		rol_arr.append(2)
	for i in range(don_count):
		rol_arr.append(5)
	for i in range(mir_count):
		rol_arr.append(1)
	for i in range(doc_count):
		rol_arr.append(4)
	for i in range(sh_count):
		rol_arr.append(0)


func dalee_pressed():
	hide_all_panels()
	all_count = ras_rol.all_count
	mafia_count = ras_rol.old_count_M
	don_count = ras_rol.old_count_don
	doc_count = ras_rol.old_count_doc
	mir_count = ras_rol.old_count_mir
	sh_count = ras_rol.old_count_sh
	rand = all_count - 1
	app_arr_rol()
	print(rol_arr)
	duplicate_panels_for_players()
	pan.hide()
	value_changed.emit(all_count)


func Daleerol_pressed():
	name_arr.append(pl_name_glob)
	if rand == -1:
		hide_all_panels()
		player_panels[current_panel_index].visible = false
		menu_panel.show()
		print(name_arr)
		name_changed.emit(name_arr)
	else:
		current_panel_index = current_panel_index + 1
		show_current_panel()


func duplicate_panels_for_players():
	# Скрываем оригинальную панель (она будет шаблоном)
	panel.visible = false
	
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_panel = panel.duplicate()
		new_panel.visible = false
		add_child(new_panel)
		player_panels.append(new_panel)
		
	show_current_panel()


func show_current_panel():
	# Скрываем все панели
	for panel_i in player_panels:
		panel_i.visible = false
		
	randomize()
	
	ind = randi_range(0, rand)
	a = rol_arr[ind]
	rol_arr.remove_at(ind)
	rand = rand - 1

	player_panels[current_panel_index].changing_the_image(a)
	player_panels[current_panel_index].visible = true
	var p = player_panels[current_panel_index]
	var but = p.get_node("MarginContainer/VBoxContainer/Button")
	p.new_name_pl.connect(app_name)
	but.pressed.connect(Daleerol_pressed)
	




#func action_of_card(i: int):
	#$Panel.changing_thе_image(i)
	

func Vvod():
	print(all_count)
	print(mafia_count)
	print(don_count)
	print(doc_count)
	print(mir_count)
	print(sh_count)
