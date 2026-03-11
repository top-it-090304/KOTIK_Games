extends Control

@onready var player_template := $MarginContainer/VBoxContainer/PanelContainer2
@onready var vbox_container := $MarginContainer/VBoxContainer

@onready var label = $MarginContainer/VBoxContainer/PanelContainer2/Label


var allcount : int = 5

func _ready() -> void:
	#var count = get_parent()
	#allcount = count.all_count
	# Скрываем шаблон
	player_template.visible = false
	# Создаем панели для игроков
	create_player_panels()

func create_player_panels():
	# Удаляем старые динамические панели (если они были созданы ранее)
	# Оставляем только шаблон
	for child in vbox_container.get_children():
		if child != player_template:
			child.queue_free()
			# Создаем новые панели для каждого игрока
	for i in range(allcount):
		# Клонируем шаблон
		var new_panel = player_template.duplicate()
		# Делаем новый узел видимым
		new_panel.visible = true
		# Меняем текст в Label внутри PanelContainer2
		# Путь к Label: PanelContainer2 -> Label (из вашей структуры)
		label.text = "Игрок %d" % (i + 1)
			# Добавляем в VBoxContainer
		vbox_container.add_child(new_panel)
