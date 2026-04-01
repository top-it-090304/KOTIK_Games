extends Control

@onready var ras_rol = $Play/MarginContainer

@onready var play_panel = $Play
@onready var panel = $Panel
@onready var menu_panel = $Menu
@onready var For_maf = $ForMafia

@onready var dalee_button: Button = $Play/MarginContainer/VBoxContainer/HBoxContainer2/Button2

@onready var pan = $Menu/PanelContainer3

#Test
@onready var Daleerol: Button = $Panel/MarginContainer/VBoxContainer/Button

@onready var menu_panel_pl = $Menu/PanelContainer3

@onready var where_label = $Menu/MarginContainer/VBoxContainer

@onready var menu_panel_M: Button = $ForMafia/Button

@onready var where_label_M = $ForMafia/MarginContainer/VBoxContainer

signal value_changed(all_count)
#signal name_changed(name_arr)

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
var rol_arr_2 =[]
var name_arr = []

func _ready() -> void:
	hide_all_panels()
	play_panel.show()
	dalee_button.pressed.connect(dalee_pressed)

#Функция которая вызывается, когда игрок меняет имя 
#(Нужна для того, чтобы использовался только последний вариант имени)
func app_name(player_name):
	pl_name_glob = player_name

func hide_all_panels():
	play_panel.hide()
	menu_panel.hide()
	panel.hide()
	For_maf.hide()


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
		#duplicate_menu_player()
		duplicate_menu_maf()
		For_maf.show()
		#menu_panel.show()
		print(name_arr)
		#name_changed.emit(name_arr)
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
	rol_arr_2.append(a)
	rol_arr.remove_at(ind)
	rand = rand - 1

	player_panels[current_panel_index].changing_the_image(a)
	player_panels[current_panel_index].visible = true
	var p = player_panels[current_panel_index]
	var but = p.get_node("MarginContainer/VBoxContainer/Button")
	p.new_name_pl.connect(app_name)
	but.pressed.connect(Daleerol_pressed)
	

#Запись имен в Label
var menu_player_dub = []

func duplicate_menu_player():
	# Скрываем оригинальную панель (она будет шаблоном)
	menu_panel_pl.visible = false
	
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_menu_panel = menu_panel_pl.duplicate()
		new_menu_panel.visible = false
		where_label.add_child(new_menu_panel)
		menu_player_dub.append(new_menu_panel)
	
	show_all_menu_panel()
		

func show_all_menu_panel():
	for i in range(all_count):
		var current = menu_player_dub[i]
		var menu_name = current.get_node("Label")
		menu_name.text = name_arr[i]
		menu_player_dub[i].visible = true


#ГЕМПЛЕЙ ДЛЯ МАФИИ

var menu_maf_dub = []

var my_button_group = ButtonGroup.new()

#Делаем дубликаты кнопок для Мафии (Кого они могут убить)
func duplicate_menu_maf():
	# Скрываем оригинальную панель (она будет шаблоном)
	menu_panel_M.visible = false
	my_button_group.allow_unpress = true
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_menu_panel_M = menu_panel_M.duplicate()
		new_menu_panel_M.visible = false
		new_menu_panel_M.button_group = my_button_group
		where_label_M.add_child(new_menu_panel_M)
		menu_maf_dub.append(new_menu_panel_M)
	
	mafia_kill()

#Загружаем кнопки для Мафии (Кого они могут убить)
func mafia_kill():
	#maf_chec.visible = false
	for i in range(all_count):
		if rol_arr_2[i] != 2 and rol_arr_2[i] != 5:
			var current = menu_maf_dub[i]
			current.text = name_arr[i]
			current.pressed.connect(mafia_check)
			menu_maf_dub[i].visible = true


@onready var ForMafia: Button = $ForMafia/MarginContainer/Button

#Работа с кнопкой СДЕЛАТЬ ВЫБОР
func mafia_check():
	var pressed_node = my_button_group.get_pressed_button()
	if pressed_node != null:
		ForMafia.disabled = false
		ForMafia.pressed.connect(mafia_after)
	else:
		ForMafia.disabled = true


@onready var maf_chec = $ForMafia/MarginContainer2
@onready var color_rect = $ForMafia/ColorRect
@onready var mafia_after_kill = $ForMafia/MarginContainer2/PanelContainer/VBoxContainer/Label

#Информация для мафии после сделаного выбора
func mafia_after():
	var selected_button = my_button_group.get_pressed_button()
	if selected_button:
		var player_name = selected_button.text
		mafia_after_kill.text = "Игрок: '" + player_name + "' убит"
	
	color_rect.visible = true
	maf_chec.visible = true
	





	

func Vvod():
	print(all_count)
	print(mafia_count)
	print(don_count)
	print(doc_count)
	print(mir_count)
	print(sh_count)
