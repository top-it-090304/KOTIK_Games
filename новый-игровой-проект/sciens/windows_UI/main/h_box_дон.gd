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
@onready var minus_button: Button = $minus_button
@onready var plus_button: Button = $plus_button
@onready var count_label: Label = $count_label

func _ready():
	# Устанавливаем начальное значение
	current_players_D = clamp(start_players, min_players, max_players)
	update_display()
	
	# Подключаем сигналы кнопок
	minus_button.pressed.connect(_on_minus_pressed)
	plus_button.pressed.connect(_on_plus_pressed)
	
	# Обновляем состояние кнопок
	update_buttons_state()

func _on_minus_pressed():
	if current_players_D > min_players:
		current_players_D -= 1
		update_display()
		update_buttons_state()
		players_count_changed.emit(current_players_D)

func _on_plus_pressed():
	if current_players_D < max_players:
		current_players_D += 1
		update_display()
		update_buttons_state()
		players_count_changed.emit(current_players_D)

func update_display():
	count_label.text = str(current_players_D)

func update_buttons_state():
	# Делаем кнопки неактивными при достижении границ
	minus_button.disabled = current_players_D <= min_players
	plus_button.disabled = current_players_D >= max_players
