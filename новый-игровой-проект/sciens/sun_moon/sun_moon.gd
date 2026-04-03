extends Panel


func get_day():
	$AnimationPlayer.play_backwards("set_day")

func get_night():
	$AnimationPlayer.play("set_day")

func _ready() -> void:
	get_day()
	
