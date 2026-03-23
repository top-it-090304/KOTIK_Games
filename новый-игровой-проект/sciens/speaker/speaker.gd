extends Control
@onready var speaker = $AnimationPlayer


func Speaker(phrase):
	speaker.play(phrase)
