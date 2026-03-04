extends Panel

@onready var screen_size = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())
@onready var card = $MarginContainer/VBoxContainer/AnimationPlayer
@onready var button = $MarginContainer/VBoxContainer/Button2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(screen_size)
	get_window().size = screen_size
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_button_2_pressed() -> void:
	
	card.play("new_animation")
	button.disabled = true
