extends MarginContainer

@onready var hbox_mafia = $"VBoxContainer/Мафия/HBox_Мафия"
@onready var hbox_mir = $"VBoxContainer/Мирный житель/HBox_Мирный"
@onready var hbox_don = $"VBoxContainer/Дон/HBox_Дон"
@onready var hbox_doc = $"VBoxContainer/Доктор/HBox_Доктор"
@onready var hbox_sh = $"VBoxContainer/Шериф/HBox_Шериф"

@onready var count_label = $"VBoxContainer/HBoxContainer/Count"

var all_count: int = 3

func _ready():
	# Подключаемся к сигналу
	hbox_mafia.players_count_changed.connect(_on_players_count_changed_M)
	hbox_mir.players_count_changed.connect(_on_players_count_changed_mir)
	hbox_don.players_count_changed.connect(_on_players_count_changed_don)
	hbox_doc.players_count_changed.connect(_on_players_count_changed_doc)
	hbox_sh.players_count_changed.connect(_on_players_count_changed_sh)
	
	count_label.text = str(all_count)

var old_count_M: int = 1

func _on_players_count_changed_M(new_count):
	# Обновляем label при каждом изменении
	all_count = all_count + new_count - old_count_M
	count_label.text = str(all_count)
	old_count_M = new_count


var old_count_mir: int = 2

func _on_players_count_changed_mir(new_count):
	# Обновляем label при каждом изменении
	all_count = all_count + new_count - old_count_mir
	count_label.text = str(all_count)
	old_count_mir = new_count


var old_count_don: int = 0

func _on_players_count_changed_don(new_count):
	# Обновляем label при каждом изменении
	all_count = all_count + new_count - old_count_don
	count_label.text = str(all_count)
	old_count_don = new_count


var old_count_doc: int = 0

func _on_players_count_changed_doc(new_count):
	# Обновляем label при каждом изменении
	all_count = all_count + new_count - old_count_doc
	count_label.text = str(all_count)
	old_count_doc = new_count


var old_count_sh: int = 0

func _on_players_count_changed_sh(new_count):
	# Обновляем label при каждом изменении
	all_count = all_count + new_count - old_count_sh
	count_label.text = str(all_count)
	old_count_sh = new_count
