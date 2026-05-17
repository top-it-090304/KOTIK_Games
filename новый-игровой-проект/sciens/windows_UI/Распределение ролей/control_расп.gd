extends Control

@onready var ras_rol = $Play/MarginContainer

@onready var play_panel = $Play
@onready var panel = $Panel
@onready var menu_panel = $Menu
@onready var For_maf = $ForMafia
@onready var For_doc = $ForDoctor
@onready var For_don = $ForDon
@onready var For_sh = $ForSh
@onready var For_af = $After_night
@onready var Speaker = $Speaker

@onready var dalee_button: Button = $Play/MarginContainer/VBoxContainer/HBoxContainer2/Button2

@onready var pan = $Menu/PanelContainer3

#Test
@onready var Daleerol: Button = $Panel/MarginContainer/VBoxContainer/Button

@onready var menu_panel_pl = $Menu/PanelContainer3

@onready var where_label = $Menu/MarginContainer/VBoxContainer

@onready var menu_panel_M: Button = $ForMafia/Button

@onready var start_night: Button = $Start/VBoxContainer/Button

@onready var where_label_M = $ForMafia/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

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

@onready var info_menu = $"Экран_опций/open_options_menu"

func _ready() -> void:
	hide_all_panels()
	play_panel.show()
	info_menu.pressed.connect(play_info_menu)
	dalee_button.pressed.connect(dalee_pressed)

#Функция которая вызывается, когда игрок меняет имя 
#(Нужна для того, чтобы использовался только последний вариант имени)

@onready var info_menu_marg = $Play/MarginContainer2
@onready var info_menu_close = $Play/MarginContainer2/MarginContainer/VBoxContainer/close_options_menu
@onready var opcii = $"Экран_опций"

func play_info_menu():
	info_menu_marg.show()
	opcii.hide()
	info_menu_close.pressed.connect(play_info_menu_close)

func play_info_menu_close():
	info_menu_marg.hide()
	opcii.show()

var app_name_i: int = 1

func app_name(player_name):
	pl_name_glob = player_name
	print("55)", pl_name_glob)

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
	opcii.hide()
	pan.hide()
	value_changed.emit(all_count)


func Daleerol_pressed():
	if pl_name_glob == " ":
		pl_name_glob = "Игрок " + str(app_name_i)
	app_name_i = app_name_i + 1
	print(app_name_i)
	name_arr.append(pl_name_glob)
	print("1)", pl_name_glob)
	pl_name_glob = " "
	if rand == -1:
		hide_all_panels()
		player_panels[current_panel_index].visible = false
		#duplicate_menu_player()
		$Start.show()
		start_night.pressed.connect(first_night)
		#menu_panel.show()
		print(name_arr)
		#name_changed.emit(name_arr)
	else:
		current_panel_index = current_panel_index + 1
		show_current_panel()

@onready var voice_start_gosleep = $Start/AudioStreamPlayer2D

func first_night():
	#get_tree().paused = true
	#await get_tree().create_timer(2.0, true).timeout
	#get_tree().paused = false
	$Start/VBoxContainer.hide()
	$Start/MarginContainer2.show()
	voice_start_gosleep.play()
	await voice_start_gosleep.finished
	get_tree().paused = true
	await get_tree().create_timer(3.0, true).timeout
	get_tree().paused = false
	$Start.hide()
	duplicate_menu_maf()
	For_maf.show()

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

var back_menu
var back_rect
var last_player
var back_to_menu
var close_back_menu

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
	var but = p.get_node("MarginContainer/VBoxContainer/HBoxContainer/Button")
	p.new_name_pl.connect(app_name)
	but.pressed.connect(Daleerol_pressed)
	var but_back = p.get_node("MarginContainer/VBoxContainer/HBoxContainer/TextureButton")
	but_back.pressed.connect(open_back)
	
	back_menu = p.get_node("MarginContainer2")
	back_rect = p.get_node("ColorRect")
	back_to_menu = p.get_node("MarginContainer2/MarginContainer/VBoxContainer/Button2")
	back_to_menu.pressed.connect(open_chose_rol)
	close_back_menu = p.get_node("MarginContainer2/MarginContainer/VBoxContainer/close_options_menu")
	close_back_menu.pressed.connect(close_back)
	last_player = p.get_node("MarginContainer2/MarginContainer/VBoxContainer/Button")
	last_player.pressed.connect(func_last_player)


func open_back():
	back_menu.show()
	back_rect.show()

func close_back():
	back_menu.hide()
	back_rect.hide()

func open_chose_rol():
	back_menu.hide()
	back_rect.hide()
	hide_all_panels()
	player_panels[current_panel_index].visible = false
	player_panels.clear()
	current_panel_index = 0
	play_panel.show()

func func_last_player():
	player_panels[current_panel_index].visible = false
	player_panels[current_panel_index - 1].visible = true
	current_panel_index = current_panel_index - 1

##Запись имен в Label
#var menu_player_dub = []
#
#func duplicate_menu_player():
	## Скрываем оригинальную панель (она будет шаблоном)
	#menu_panel_pl.visible = false
	#
	## Создаем панели для каждого игрока
	#for i in range(all_count):
		#var new_menu_panel = menu_panel_pl.duplicate()
		#new_menu_panel.visible = false
		#where_label.add_child(new_menu_panel)
		#menu_player_dub.append(new_menu_panel)
	#
	#show_all_menu_panel()
		#
#
#func show_all_menu_panel():
	#for i in range(all_count):
		#var current = menu_player_dub[i]
		#var menu_name = current.get_node("Label")
		#menu_name.text = name_arr[i]
		#menu_player_dub[i].visible = true

####################################################################################################

#ГЕМПЛЕЙ ДЛЯ МАФИИ

@onready var voice_mafia_wakeup = $ForMafia/AudioStreamPlayer2D
@onready var voice_mafia_gosleep = $ForMafia/AudioStreamPlayer2D2

var menu_maf_dub = []

var my_button_group = ButtonGroup.new()

var index_dead_player

@onready var helper_mafia = $ForMafia/MarginContainer3
@onready var helper_mafia_close = $ForMafia/MarginContainer3/MarginContainer/VBoxContainer/close_options_menu

func mafia_helper_open():
	helper_mafia.show()
	opcii.hide()
	helper_mafia_close.pressed.connect(mafia_helper_close)

func mafia_helper_close():
	helper_mafia.hide()
	opcii.show()

#info_menu.pressed.connect(mafia_helper_open)

#Делаем дубликаты кнопок для Мафии (Кого они могут убить)
func duplicate_menu_maf():
	opcii.show()
	info_menu.show()
	helper_mafia.hide()
	info_menu_day.hide()
	info_menu.pressed.connect(mafia_helper_open)
	menu_maf_dub = []
	my_button_group = ButtonGroup.new()
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
			current.pressed.connect(mafia_check)#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			menu_maf_dub[i].visible = true
	voice_mafia_wakeup.play()

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
		index_dead_player = name_arr.find(player_name)
		mafia_after_kill.text = "Игрок: '" + player_name + "' убит"
		get_tree().paused = true
		await get_tree().create_timer(2.0, true).timeout
		get_tree().paused = false
		voice_mafia_gosleep.play()
		await voice_mafia_gosleep.finished
		get_tree().paused = true
		await get_tree().create_timer(3.0, true).timeout
		get_tree().paused = false
		For_maf.hide()
		color_rect.visible = false
		maf_chec.visible = false
		for child in where_label_M.get_children():
			if child is Button:
				child.queue_free()
		if don_count == 1:
				For_don.show()
				duplicate_menu_don()
		else:
			if doc_count == 1:
				For_doc.show()
				duplicate_menu_doc()
			else:
				if sh_count == 1:
					For_sh.show()
					duplicate_menu_sh()
				else:
					after_night()



####################################################################################################

#ДЛЯ ДОКТОРА
@onready var menu_panel_D: Button = $ForDoctor/Button
@onready var where_label_D = $ForDoctor/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

@onready var voice_doctor_wakeup = $ForDoctor/AudioStreamPlayer2D
@onready var voice_doctor_gosleep = $ForDoctor/AudioStreamPlayer2D2 

var menu_doc_dub = []

var my_button_group_doc = ButtonGroup.new()

var index_heal_player

@onready var helper_doc = $ForDoctor/MarginContainer3
@onready var helper_doc_close = $ForDoctor/MarginContainer3/MarginContainer/VBoxContainer/close_options_menu

func doc_helper_open():
	helper_doc.show()
	opcii.hide()
	helper_doc_close.pressed.connect(doc_helper_close)

func doc_helper_close():
	helper_doc.hide()
	opcii.show()

#info_menu.pressed.connect(mafia_helper_open)

#Делаем дубликаты кнопок для Мафии (Кого они могут убить)
func duplicate_menu_doc():
	helper_doc.hide()
	info_menu.pressed.connect(doc_helper_open)
	menu_doc_dub = []
	my_button_group_doc = ButtonGroup.new()
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
	voice_doctor_wakeup.play()

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
		if "Себя" in player_name:
			player_name = player_name.left(-7)
		index_heal_player = name_arr.find(player_name)
	color_rect_doc.visible = true
	doc_chec.visible = true
	get_tree().paused = true
	await get_tree().create_timer(2.0, true).timeout
	get_tree().paused = false
	voice_doctor_gosleep.play()
	await voice_doctor_gosleep.finished
	get_tree().paused = true
	await get_tree().create_timer(3.0, true).timeout
	get_tree().paused = false
	For_doc.hide()
	color_rect_doc.visible = false
	doc_chec.visible = false
	for child in where_label_D.get_children():
			if child is Button:
				child.queue_free()
	if sh_count == 1:
		For_sh.show()
		duplicate_menu_sh()
	else:
		after_night()

	#after_night()

	
####################################################################################################

#ДЛЯ ДОНА

@onready var menu_panel_Don: Button = $ForDon/Button
@onready var where_label_Don = $ForDon/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

@onready var voice_don_wakeup = $ForDon/AudioStreamPlayer2D
@onready var voice_don_gosleep = $ForDon/AudioStreamPlayer2D2 

var menu_don_dub = []

var my_button_group_don = ButtonGroup.new()

@onready var helper_don = $ForDon/MarginContainer3
@onready var helper_don_close = $ForDon/MarginContainer3/MarginContainer/VBoxContainer/close_options_menu

func don_helper_open():
	helper_don.show()
	opcii.hide()
	helper_don_close.pressed.connect(don_helper_close)

func don_helper_close():
	helper_don.hide()
	opcii.show()

#info_menu.pressed.connect(mafia_helper_open)

#Делаем дубликаты кнопок для Дона (Кого он может проверить на шерифа)
func duplicate_menu_don():
	helper_don.hide()
	info_menu.pressed.connect(don_helper_open)
	menu_don_dub = []
	my_button_group_don = ButtonGroup.new()
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

#Загружаем кнопки для Дона (Кого он может проверить на шерифа)
func don_test():
	#maf_chec.visible = false
	for i in range(all_count):
		if rol_arr_2[i] != 2 and rol_arr_2[i] != 5:
			var current = menu_don_dub[i]
			current.text = name_arr[i]
			current.pressed.connect(don_check)
			menu_don_dub[i].visible = true
	voice_don_wakeup.play()


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

#Информация для Дона после сделаного выбора
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
	don_go_sleep1.visible = true

#Остановка после нажатия кнопки ЛЕЧЬ СПАТЬ
func don_sleep():
	don_go_sleep1.visible = false
	don_go_sleep2.visible = true
	get_tree().paused = true
	await get_tree().create_timer(2.0, true).timeout
	get_tree().paused = false
	voice_don_gosleep.play()
	await voice_don_gosleep.finished
	get_tree().paused = true
	await get_tree().create_timer(3.0, true).timeout
	get_tree().paused = false
	For_don.hide()
	don_go_sleep2.visible = false
	color_rect_don.visible = false
	don_chec.visible = false
	for child in where_label_Don.get_children():
			if child is Button:
				child.queue_free()
	if doc_count == 1:
		For_doc.show()
		duplicate_menu_doc()
	else:
		if sh_count == 1:
			For_sh.show()
			duplicate_menu_sh()
		else:
			after_night()



####################################################################################################

#ДЛЯ ШЕРИФА

@onready var menu_panel_Sh: Button = $ForSh/Button
@onready var where_label_Sh = $ForSh/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

@onready var voice_sh_wakeup = $ForSh/AudioStreamPlayer2D
@onready var voice_sh_gosleep = $ForSh/AudioStreamPlayer2D2 

var menu_sh_dub = []

var my_button_group_sh = ButtonGroup.new()

@onready var helper_sh = $ForSh/MarginContainer3
@onready var helper_sh_close = $ForSh/MarginContainer3/MarginContainer/VBoxContainer/close_options_menu

func sh_helper_open():
	helper_sh.show()
	opcii.hide()
	helper_sh_close.pressed.connect(sh_helper_close)

func sh_helper_close():
	helper_sh.hide()
	opcii.show()

#info_menu.pressed.connect(mafia_helper_open)

#Делаем дубликаты кнопок для Мафии (Кого они могут убить)
func duplicate_menu_sh():
	helper_sh.hide()
	info_menu.pressed.connect(sh_helper_open)
	menu_sh_dub = []
	my_button_group_sh = ButtonGroup.new()
	# Скрываем оригинальную панель (она будет шаблоном)
	menu_panel_Sh.visible = false
	my_button_group_sh.allow_unpress = true
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_menu_panel_Sh = menu_panel_Don.duplicate()
		new_menu_panel_Sh.visible = false
		new_menu_panel_Sh.button_group = my_button_group_sh
		where_label_Sh.add_child(new_menu_panel_Sh)
		menu_sh_dub.append(new_menu_panel_Sh)
	
	sh_test()

#Загружаем кнопки для Мафии (Кого они могут убить)
func sh_test():
	#maf_chec.visible = false
	for i in range(all_count):
		if rol_arr_2[i] != 0:
			var current = menu_sh_dub[i]
			current.text = name_arr[i]
			current.pressed.connect(sh_check)
			menu_sh_dub[i].visible = true
	voice_sh_wakeup.play()

@onready var ForSh: Button = $ForSh/MarginContainer/Button

#Работа с кнопкой СДЕЛАТЬ ВЫБОР
func sh_check():
	var pressed_node = my_button_group_sh.get_pressed_button()
	if pressed_node != null:
		ForSh.disabled = false
		ForSh.pressed.connect(sh_after)
	else:
		ForSh.disabled = true


@onready var sh_chec = $ForSh/MarginContainer2
@onready var color_rect_sh = $ForSh/ColorRect
@onready var sh_after_test = $ForSh/MarginContainer2/PanelContainer/VBoxContainer/Label
@onready var sh_after_test2 = $ForSh/MarginContainer2/PanelContainer/VBoxContainer/Label3
@onready var ForSh_sleep: Button = $ForSh/MarginContainer2/PanelContainer/VBoxContainer/Button
@onready var sh_go_sleep1 = $ForSh/MarginContainer2/PanelContainer
@onready var sh_go_sleep2 = $ForSh/MarginContainer2/PanelContainer2

#Информация для мафии после сделаного выбора
func sh_after():
	var selected_button = my_button_group_sh.get_pressed_button()
	if selected_button:
		var player_name = selected_button.text
		sh_after_test.text = "Игрок: '" + player_name + "'"
		var i = name_arr.find(player_name)
		if rol_arr_2[i] == 2 or rol_arr_2[i] == 5:
			sh_after_test2.text = "ЯВЛЯЕТСЯ мафией"
		else:
			sh_after_test2.text = "НЕ является мафией"
	ForSh_sleep.pressed.connect(sh_sleep)
	color_rect_sh.visible = true
	sh_chec.visible = true
	sh_go_sleep1.visible = true


func sh_sleep():
	sh_go_sleep1.visible = false
	sh_go_sleep2.visible = true
	get_tree().paused = true
	await get_tree().create_timer(2.0, true).timeout
	get_tree().paused = false
	voice_sh_gosleep.play()
	await voice_sh_gosleep.finished
	get_tree().paused = true
	await get_tree().create_timer(3.0, true).timeout
	get_tree().paused = false
	For_sh.hide()
	sh_go_sleep2.visible = false
	color_rect_sh.visible = false
	sh_chec.visible = false
	for child in where_label_Sh.get_children():
			if child is Button:
				child.queue_free()
	after_night()


####################################################################################################

@onready var voice_day_wakeup = $After_night/AudioStreamPlayer2D
@onready var voice_day_gosleep = $After_night/AudioStreamPlayer2D2

var dead_name
var heal_name

func after_night():
	dead_name = name_arr[index_dead_player]
	if doc_count == 1:
		heal_name = name_arr[index_heal_player]
	if index_heal_player != index_dead_player:
		all_count = all_count - 1
		name_arr.remove_at(index_dead_player)
		rol_arr_2.remove_at(index_dead_player)
	if (all_count - mafia_count - don_count <= mafia_count + don_count) :
		$End/VBoxContainer/PanelContainer2/Label.text = "Мафия победила"
		$End.show()
		opcii.hide()
	elif(mafia_count + don_count == 0):
		$End/VBoxContainer/PanelContainer2/Label.text = "Мирные жители победили"
		print("This")
		$End.show()
		opcii.hide()
	else:
		For_af.show()
		$"Виньетка".hide()
		$Day.show()
		
		duplicate_menu_af()


@onready var menu_panel_Af: Button = $After_night/Button
@onready var where_label_Af = $After_night/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
@onready var choice_Af = $After_night/MarginContainer

@onready var info_menu_day = $"Экран_опций/TButton_Day"

var menu_af_dub = []

var my_button_group_af = ButtonGroup.new()

@onready var helper_af = $After_night/MarginContainer3
@onready var helper_af_close = $After_night/MarginContainer3/MarginContainer/VBoxContainer/close_options_menu

func af_helper_open():
	helper_af.show()
	opcii.hide()
	helper_af_close.pressed.connect(af_helper_close)

func af_helper_close():
	helper_af.hide()
	opcii.show()

#info_menu.pressed.connect(mafia_helper_open)

#Делаем дубликаты кнопок для Мафии (Кого они могут убить)
func duplicate_menu_af():
	info_menu.hide()
	info_menu_day.show()
	info_menu_day.pressed.connect(af_helper_open)
	menu_af_dub = []
	my_button_group_af = ButtonGroup.new()
	# Скрываем оригинальную панель (она будет шаблоном)
	menu_panel_Af.visible = false
	my_button_group_af.allow_unpress = true
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_menu_panel_Af = menu_panel_Af.duplicate()
		new_menu_panel_Af.visible = false
		new_menu_panel_Af.button_group = my_button_group_af
		where_label_Af.add_child(new_menu_panel_Af)
		menu_af_dub.append(new_menu_panel_Af)
	
	af_test()

#Загружаем кнопки для Мафии (Кого они могут убить)
func af_test():
	#maf_chec.visible = false
	for i in range(all_count):
		var current = menu_af_dub[i]
		current.text = name_arr[i]
		current.pressed.connect(af_check)
		menu_af_dub[i].visible = true
	voice_day_wakeup.play()
	info_after_night()

@onready var ForAf: Button = $After_night/MarginContainer/Button

#Работа с кнопкой СДЕЛАТЬ ВЫБОР
func af_check():
	var pressed_node = my_button_group_af.get_pressed_button()
	if pressed_node != null:
		ForAf.disabled = false
		ForAf.pressed.connect(af_after)
	else:
		ForAf.disabled = true


@onready var af_chec = $After_night/MarginContainer2
@onready var color_rect_af = $After_night/ColorRect
@onready var af_after_test = $After_night/MarginContainer2/PanelContainer/VBoxContainer/Label
@onready var af_after_test2 = $After_night/MarginContainer2/PanelContainer/VBoxContainer/Label3
@onready var ForAf_sleep: Button = $After_night/MarginContainer2/PanelContainer/VBoxContainer/Button
@onready var af_go_sleep1 = $After_night/MarginContainer2/PanelContainer
@onready var af_go_sleep2 = $After_night/MarginContainer2/PanelContainer2

#Информация для мафии после сделаного выбора
func af_after():
	var selected_button = my_button_group_af.get_pressed_button()
	if selected_button:
		var player_name = selected_button.text
		var index_removed_player = name_arr.find(player_name)
		all_count = all_count - 1
		name_arr.remove_at(index_removed_player)
		var what_rol_dead = rol_arr_2[index_removed_player]
		rol_arr_2.remove_at(index_removed_player)
		if what_rol_dead == 0:
			sh_count = sh_count - 1
		if what_rol_dead == 4:
			doc_count = doc_count - 1
		if what_rol_dead == 5:
			don_count = don_count - 1
		if what_rol_dead == 2:
			mafia_count = mafia_count - 1
		af_after_test.text = "Игрок: '" + player_name + "'"
		#var i = name_arr.find(player_name)
		af_after_test2.text = "Исключён"
	ForAf_sleep.pressed.connect(af_sleep)
	color_rect_af.visible = true
	af_chec.visible = true
	af_go_sleep1.visible = true

func af_sleep():
	if  (mafia_count + don_count == 0):
		$End/VBoxContainer/PanelContainer2/Label.text = "Мирные жители победили"
		print("This")
		For_af.hide()
		$Day.hide()
		$End.show()
		opcii.hide()
	elif (all_count - mafia_count - don_count <= mafia_count + don_count) :
		$End/VBoxContainer/PanelContainer2/Label.text = "Мафия победила"
		print("This")
		For_af.hide()
		$Day.hide()
		$End.show()
		opcii.hide()
	else:
		af_go_sleep1.visible = false
		af_go_sleep2.visible = true
		get_tree().paused = true
		await get_tree().create_timer(2.0, true).timeout
		get_tree().paused = false
		voice_day_gosleep.play()
		await voice_day_gosleep.finished
		get_tree().paused = true
		await get_tree().create_timer(3.0, true).timeout
		get_tree().paused = false
		For_af.hide()
		$Day.hide()
		$Night.show()
		af_go_sleep2.visible = false
		color_rect_af.visible = false
		af_chec.visible = false
		for child in where_label_Af.get_children():
			if child is Button:
				child.queue_free()
		For_maf.show()
		duplicate_menu_maf()



@onready var dead_person = $After_night/MarginContainer2/PanelContainer3/VBoxContainer/Label
@onready var heal_person = $After_night/MarginContainer2/PanelContainer3/VBoxContainer/Label2
@onready var info_person = $After_night/MarginContainer2/PanelContainer3
@onready var info_dalee: Button = $After_night/MarginContainer2/PanelContainer3/VBoxContainer/Button

func info_after_night():
	af_chec.visible = true
	color_rect_af.visible = true
	info_person.visible = true
	dead_person.text = "Игрок: '" + dead_name + "' убит"
	if doc_count == 1:
		heal_person.text = "Игрок: '" + heal_name + "' вылечен"
		heal_name = null
	info_dalee.pressed.connect(after_show_info)

func after_show_info():
	color_rect_af.visible = false
	info_person.visible = false
	af_chec.visible = false
	#color_rect_af.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#menu_panel_Af.visible = true
	choice_Af.visible = true











func Vvod():
	print(all_count)
	print(mafia_count)
	print(don_count)
	print(doc_count)
	print(mir_count)
	print(sh_count)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://sciens/windows_UI/main_screen/menu_container.tscn")
