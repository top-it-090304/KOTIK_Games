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

#Переменные со всей информацией
var all_count: int = 0
var mafia_count: int = 0
var don_count: int = 0
var doc_count: int = 0
var mir_count: int = 0
var sh_count: int = 0
var a: int = 1

var player_panels = []  # массив для хранения созданных панелей
var current_panel_index: int = 0  # индекс текущей панели



func _ready() -> void:
	hide_all_panels()
	play_panel.show()
	dalee_button.pressed.connect(dalee_pressed)
	


func hide_all_panels():
	play_panel.hide()
	menu_panel.hide()
	panel.hide()


func dalee_pressed():
	hide_all_panels()
	all_count = ras_rol.all_count
	mafia_count = ras_rol.old_count_M
	don_count = ras_rol.old_count_don
	doc_count = ras_rol.old_count_doc
	mir_count = ras_rol.old_count_mir
	sh_count = ras_rol.old_count_sh
	
	duplicate_panels_for_players()
	
	#action_of_card()
	#panel.show()
	pan.hide()
	#Vvod()
	value_changed.emit(all_count)

func Daleerol_pressed():
	current_panel_index = current_panel_index + 1
	show_current_panel()
	print(9)

func duplicate_panels_for_players():
	# Скрываем оригинальную панель (она будет шаблоном)
	panel.visible = false
	
	# Создаем панели для каждого игрока
	for i in range(all_count):
		var new_panel = panel.duplicate()
		new_panel.visible = false
		#new_panel.name = "Panel_Player_%d" % (i + 1)
		
		# Настраиваем содержимое панели под конкретного игрока
		# Добавляем панель в Control1 (на тот же уровень, что и оригинал
		add_child(new_panel)
		player_panels.append(new_panel)
		print(0)
	show_current_panel()
		# Важно: перемещаем панель выше по иерархии, чтобы она не перекрывала интерфейс
		# Если нужно, чтобы панели были одна за другой, а не накладывались
		# Но так как панель на весь экран, они будут перекрывать друг друга
		
		# Если нужно показывать только одну панель за раз:
		# new_panel.visible = false  # и показывать по необходимости




func show_current_panel():
	# Скрываем все панели
	for panel_i in player_panels:
		panel_i.visible = false
	print(a)

	player_panels[current_panel_index].changing_the_image(a)
	player_panels[current_panel_index].visible = true
	var p = player_panels[current_panel_index]
	var but = p.get_node("MarginContainer/VBoxContainer/Button")
	but.pressed.connect(Daleerol_pressed)
	a = a + 1




func action_of_card(i: int):
	$Panel.changing_thе_image(i)
	

func Vvod():
	print(all_count)
	print(mafia_count)
	print(don_count)
	print(doc_count)
	print(mir_count)
	print(sh_count)
