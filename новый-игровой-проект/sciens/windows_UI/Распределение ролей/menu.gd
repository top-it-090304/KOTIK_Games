extends Control

@onready var player_template = $PanelContainer3
@onready var vbox_container = $MarginContainer/VBoxContainer

@onready var label = $PanelContainer3/Label

var allcount : int = 5

var Player_name_Men = []

func _ready() -> void:
	vbox_container.remove_child(player_template)
	#var count = get_parent()
	#allcount = count.all_count
	get_parent().value_changed.connect(_on_value_changed)
	get_parent().name_changed.connect(_on_name)
	# Скрываем шаблон
	#player_template.visible = false
	# Создаем панели для игроков

func _on_value_changed(all):
	allcount = all
	create_player_panels()

func _on_name(name_menu):
	Player_name_Men = name_menu
	print(Player_name_Men)



func create_player_panels():
	# Удаляем старые динамические панели (если они были созданы ранее)
	# Оставляем только шаблон
	#allcount = con.all_coun
	#vbox_container.remove_child(player_template)
	#for child in vbox_container.get_children():
		#if child != player_template:
			#child.queue_free()
			# Создаем новые панели для каждого игрока
	player_template.hide()
	for i in range(allcount):
		# Клонируем шаблон
		var new_panel = player_template.duplicate()
		# Делаем новый узел видимым
		new_panel.visible = true
		# Меняем текст в Label внутри PanelContainer2
		# Путь к Label: PanelContainer2 -> Label (из вашей структуры)
		label.text = "Игрок %d" % (i + 2)
			# Добавляем в VBoxContainer
		vbox_container.add_child(new_panel)
