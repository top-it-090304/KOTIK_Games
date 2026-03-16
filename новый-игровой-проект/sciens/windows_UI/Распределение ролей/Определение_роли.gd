extends Panel

@onready var card_animation = $AnimationPlayer
@onready var button = $MarginContainer/VBoxContainer/Button2
@onready var lineedit = $MarginContainer/VBoxContainer/LineEdit
@onready var audio = $AudioStreamPlayer
var turned_over = false
var n: String = " "

signal new_name_pl(n)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/AnimatedSprite2D.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.


func changing_the_image(number_of_card):
	$MarginContainer/VBoxContainer/AnimatedSprite2D.frame = number_of_card


func _on_button_2_pressed() -> void:
	#changing_thе_image(2)
	if turned_over == false:
		card_animation.play("forward")
		audio.playing = true
		turned_over = true
	elif turned_over == true:
		card_animation.play_backwards("back")
		audio.playing = true
		turned_over = false
	


func _on_line_edit_editing_toggled(_toggled_on: bool) -> void:
	n = lineedit.text
	new_name_pl.emit(n)
	print(n)
	
