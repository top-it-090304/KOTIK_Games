extends Panel

@onready var screen_size = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())
@onready var card_animation = $MarginContainer/VBoxContainer/AnimationPlayer
@onready var button = $MarginContainer/VBoxContainer/Button2
@onready var lineedit = $MarginContainer/VBoxContainer/LineEdit
@onready var audio = $AudioStreamPlayer2

var name_
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(screen_size)
	get_window().size = screen_size
	


# Called every frame. 'delta' is the elapsed time since the previous frame.





func _on_button_2_pressed() -> void:
	card_animation.play("RESET")
	button.disabled = true


func _on_line_edit_editing_toggled(toggled_on: bool) -> void:
	name_ = lineedit.text
	print(name_)


func _on_button_pressed() -> void:
	audio.playing = true 
