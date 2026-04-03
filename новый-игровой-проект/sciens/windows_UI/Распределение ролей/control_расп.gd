extends Control

@onready var ras_rol = $Play/MarginContainer

@onready var play_panel = $Play
@onready var panel = $Panel
@onready var menu_panel = $Menu
@onready var For_maf = $ForMafia
@onready var For_doc = $ForDoctor
@onready var For_don = $ForDon

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
	color_rect.visible = true
	maf_chec.visible = true
	var selected_button = my_button_group.get_pressed_button()
	if selected_button:
		var player_name = selected_button.text
		mafia_after_kill.text = "Игрок: '" + player_name + "' убит"
		get_tree().paused = true
		await get_tree().create_timer(5.0, true).timeout
		get_tree().paused = false
		For_maf.hide()
		For_doc.show()
		duplicate_menu_doc()
	

	



#ДЛЯ ДОКТОРА
@onready var menu_panel_D: Button = $ForDoctor/Button
@onready var where_label_D = $ForDoctor/MarginContainer/VBoxContainer

var menu_doc_dub = []

var my_button_group_doc = ButtonGroup.new()

#Делаем дубликаты кнопок для Мафии (Кого они могут убить)
func duplicate_menu_doc():
	# Скрываем оригинальную панель (она будет шаблоном)
	menu_panel_D.visible = false
	my_button_group_doc.allow_unpress = true
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_menu_panel_D = menu_panel_D.duplicate()
		new_menu_panel_D.visible = false
		new_menu_panel_D.button_group = my_button_group_doc
		where_label_D.add_child(new_menu_panel_D)
		menu_doc_dub.append(new_menu_panel_D)
	
	doctor_heal()

#Загружаем кнопки для Мафии (Кого они могут убить)
func doctor_heal():
	#maf_chec.visible = false
	for i in range(all_count):
		if rol_arr_2[i] == 4:
			var current = menu_doc_dub[i]
			current.text = name_arr[i] + " (Себя)"
			current.pressed.connect(doctor_check)
			menu_doc_dub[i].visible = true
		else:
			var current = menu_doc_dub[i]
			current.text = name_arr[i]
			current.pressed.connect(doctor_check)
			menu_doc_dub[i].visible = true


@onready var ForDoctor: Button = $ForDoctor/MarginContainer/Button

#Работа с кнопкой СДЕЛАТЬ ВЫБОР
func doctor_check():
	var pressed_node = my_button_group_doc.get_pressed_button()
	if pressed_node != null:
		ForDoctor.disabled = false
		ForDoctor.pressed.connect(doctor_after)
	else:
		ForDoctor.disabled = true


@onready var doc_chec = $ForDoctor/MarginContainer2
@onready var color_rect_doc = $ForDoctor/ColorRect
@onready var doc_after_heal = $ForDoctor/MarginContainer2/PanelContainer/VBoxContainer/Label

#Информация для мафии после сделаного выбора
func doctor_after():
	var selected_button = my_button_group_doc.get_pressed_button()
	if selected_button:
		var player_name = selected_button.text
		doc_after_heal.text = "'" + player_name + "'"
	color_rect_doc.visible = true
	doc_chec.visible = true
	get_tree().paused = true
	await get_tree().create_timer(5.0, true).timeout
	get_tree().paused = false
	For_maf.hide()
	For_don.show()
	duplicate_menu_don()

	

#ДЛЯ ДОНА
@onready var menu_panel_Don: Button = $ForDon/Button
@onready var where_label_Don = $ForDon/MarginContainer/VBoxContainer

var menu_don_dub = []

var my_button_group_don = ButtonGroup.new()

#Делаем дубликаты кнопок для Мафии (Кого они могут убить)
func duplicate_menu_don():
	# Скрываем оригинальную панель (она будет шаблоном)
	menu_panel_Don.visible = false
	my_button_group_don.allow_unpress = true
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_menu_panel_Don = menu_panel_Don.duplicate()
		new_menu_panel_Don.visible = false
		new_menu_panel_Don.button_group = my_button_group_don
		where_label_Don.add_child(new_menu_panel_Don)
		menu_don_dub.append(new_menu_panel_Don)
	
	don_test()

#Загружаем кнопки для Мафии (Кого они могут убить)
func don_test():
	#maf_chec.visible = false
	for i in range(all_count):
		if rol_arr_2[i] != 2 and rol_arr_2[i] != 5:
			var current = menu_don_dub[i]
			current.text = name_arr[i]
			current.pressed.connect(don_check)
			menu_don_dub[i].visible = true


@onready var ForDon: Button = $ForDon/MarginContainer/Button

#Работа с кнопкой СДЕЛАТЬ ВЫБОР
func don_check():
	var pressed_node = my_button_group_don.get_pressed_button()
	if pressed_node != null:
		ForDon.disabled = false
		ForDon.pressed.connect(don_after)
	else:
		ForDon.disabled = true


@onready var don_chec = $ForDon/MarginContainer2
@onready var color_rect_don = $ForDon/ColorRect
@onready var don_after_test = $ForDon/MarginContainer2/PanelContainer/VBoxContainer/Label
@onready var don_after_test2 = $ForDon/MarginContainer2/PanelContainer/VBoxContainer/Label3
@onready var ForDon_sleep: Button = $ForDon/MarginContainer2/PanelContainer/VBoxContainer/Button
@onready var don_go_sleep1 = $ForDon/MarginContainer2/PanelContainer
@onready var don_go_sleep2 = $ForDon/MarginContainer2/PanelContainer2

#Информация для мафии после сделаного выбора
func don_after():
	var selected_button = my_button_group_don.get_pressed_button()
	if selected_button:
		var player_name = selected_button.text
		don_after_test.text = "Игрок: '" + player_name + "'"
		var i = name_arr.find(player_name)
		if rol_arr_2[i] == 0:
			don_after_test2.text = "ЯВЛЯЕТСЯ шерифом"
		else:
			don_after_test2.text = "НЕ является шерифом"
	ForDon_sleep.pressed.connect(don_sleep)
	color_rect_don.visible = true
	don_chec.visible = true


func don_sleep():
	don_go_sleep1.visible = false
	don_go_sleep2.visible = true










func Vvod():
	print(all_count)
	print(mafia_count)
	print(don_count)
	print(doc_count)
	print(mir_count)
	print(sh_count)
