extends Panel

@onready var card_animation = $AnimationPlayer
@onready var button = $MarginContainer/VBoxContainer/Button2
@onready var lineedit = $MarginContainer/VBoxContainer/LineEdit
@onready var audio = $Speaker
var turned_over = false
var n: String = " "

signal new_name_pl(n)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/AnimatedSprite2D.visible = false
	lineedit.text_changed.connect(_on_line_edit_text_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.


func changing_the_image(number_of_card):
	$MarginContainer/VBoxContainer/AnimatedSprite2D.frame = number_of_card


func _on_button_2_pressed() -> void:
	#changing_thе_image(2)
	if turned_over == false:
		card_animation.play("forward")
		audio.sound_efect("upheaval")
		turned_over = true
	elif turned_over == true:
		card_animation.play_backwards("back")
		audio.sound_efect("upheaval")
		turned_over = false
	


#func _on_line_edit_editing_toggled(_toggled_on: bool) -> void:
	#n = lineedit.text
	#new_name_pl.emit(n)
	##print(n)

func _on_line_edit_text_changed(_pl_name):
	n = _pl_name
	new_name_pl.emit(n)
