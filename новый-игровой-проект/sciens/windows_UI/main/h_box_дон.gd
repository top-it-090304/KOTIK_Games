extends HBoxContainer

# Экспортируемая переменная для настройки в инспекторе
@export var min_players: int = 0
@export var max_players: int = 1
@export var start_players: int = 0

# Текущее количество игроков
var current_players_D: int = 1

# Сигнал для отправки количества игроков в другие скрипты
signal players_count_changed(current_players_D)

# Ссылки на узлы
@onready var check_button: Button = $CheckButton

@onready var count_label: Label = $count_label

func _ready():
	# Устанавливаем начальное значение
	current_players_D = clamp(start_players, min_players, max_players)
	update_display()
	
	# Подключаем сигналы кнопок

	check_button.pressed.connect(_on_check_up)

	# Обновляем состояние кнопок




func _on_check_up():
	if check_button.button_pressed == true:
		print("on")
		current_players_D += 1
		update_display()
		players_count_changed.emit(current_players_D)
	elif check_button.button_pressed == false:
		print("off")
		current_players_D -= 1
		update_display()
		players_count_changed.emit(current_players_D)





func update_display():
	count_label.text = str(current_players_D)
